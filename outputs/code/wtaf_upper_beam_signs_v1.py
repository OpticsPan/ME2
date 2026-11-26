"""Trace the v9 upper X/Y beams under one physical installation error at a time.

The length unit is mm. Rotations are active, right-handed, in rad. Each mark
is kept at the world origin (T = -mark). True stage angles are supplied to
isolate the optical signature. wtaf_ifm_replay_v1.m tests estimated angles.
Run with Python 3 and NumPy. The training PDFs and MATLAB file are unchanged.
"""
import numpy as np


def rotation(axis, angle):
    result = np.eye(3)
    i, j = (axis + 1) % 3, (axis + 2) % 3
    result[i, i] = result[j, j] = np.cos(angle)
    result[i, j], result[j, i] = -np.sin(angle), np.sin(angle)
    return result


def intersect(p, direction, plane_point, normal):
    length = np.dot(plane_point - p, normal) / np.dot(direction, normal)
    return length, p + length * direction


def double_pass(p, direction, mirror, normal):
    # Four segments and inversion at the retroreflector as in v9,
    # trace_cc_double_pass. The reference plane passes through the beam origin.
    t1, q1 = intersect(p, direction, mirror, normal)
    reflected = direction - 2 * np.dot(direction, normal) * normal
    t2, q2 = intersect(q1, reflected, p, direction)
    t3, q4 = intersect(2 * p - q2, -reflected, mirror, normal)
    t4, _ = intersect(q4, -direction, p, direction)
    return t1 + t2 + t3 + t4


def upper_range(axis, translation, R, errors):
    # Geometry, incidence, readout sign and OPL/4 follow measure_ifm and
    # trace_all_beams in sim_ws_ifm_6dof_animation_v9.m.
    def e(key):
        return errors.get(key, 0.0)
    if axis == 0:
        starts = [np.array([-480., y + e("ee_err"), -43.5 - e("ax_err")])
                  for y in (-105., 105.)]
        direction = rotation(2, e("Rzix0")) @ rotation(1, e("Ryix0")) @ np.eye(3)[0]
        face = np.array([-200., 0., 0.])
        mirror_axis = rotation(1, e("sxz")) @ (-np.eye(3)[0])
    else:
        starts = [np.array([x + e("dd_err"), -425., -32.5 - e("ay_err")])
                  for x in (-90., 90.)]
        direction = rotation(2, e("Rziy0")) @ rotation(0, e("Rxiy0")) @ np.eye(3)[1]
        face = np.array([0., -190., 0.])
        mirror_axis = rotation(2, e("sxy")) @ rotation(0, e("syz")) @ (-np.eye(3)[1])
    mirror = R @ (face + translation)
    normal = R @ mirror_axis
    return np.mean([double_pass(p, direction, mirror, normal) / 4 for p in starts])


def correction_slopes(axis, translation, errors, step):
    slopes = []
    for k in range(3):
        def difference(sign):
            R = rotation(k, sign * step)
            return upper_range(axis, translation, R, errors) - upper_range(axis, translation, R, {})
        # Mark is fixed at the AA reference. The new solver term must cancel
        # the change of the old upper-range signal when installation is perturbed.
        slopes.append(-(difference(1) - difference(-1)) / (2 * step))
    return np.array(slopes)


def identify_case(field, injected, step):
    positions = [np.array([-90., -80., 0.]), np.array([90., 80., 0.])]
    fits = []
    for axis in range(2):
        gaps = np.array([280. + p[0] if axis == 0 else 235. + p[1] for p in positions])
        v = np.stack([correction_slopes(axis, p, {field: injected}, step) for p in positions])
        gradient = (v[1] - v[0]) / (gaps[1] - gaps[0])
        intercept = v[0] - gaps[0] * gradient
        if axis == 0:
            fits.extend([intercept[1], -intercept[2], -gradient[1], -gradient[2], v[:, 0].mean()])
        else:
            fits.extend([-intercept[0], intercept[2], -gradient[0], -gradient[2], v[:, 1].mean()])
    return np.array(fits)


if __name__ == "__main__":
    # Position-scale gain is fixed at one. "Physical" means a cfg.err input,
    # while "coefficient" means an additive change of a specific solver weight.
    cases = [("ax_err", 0.10, 0, "X2"), ("ee_err", 0.10, 1, "X3"),
             ("Ryix0", 1e-4, 2, "X5"), ("Rzix0", 1e-4, 3, "X6"),
             ("ay_err", 0.10, 5, "Y2"), ("dd_err", 0.10, 6, "Y3"),
             ("Rxiy0", 1e-4, 7, "Y6"), ("Rziy0", 1e-4, 8, "Y7")]
    for field, injected, idx, label in cases:
        fitted = identify_case(field, injected, 1e-4)
        smaller = identify_case(field, injected, 5e-5)
        ratio = fitted[idx] / injected
        print(f"{field:7s} -> {label}: coeff/input {ratio:+.6f}, half-step {smaller[idx]/injected:+.6f}")
        expected = -1 if field in ("ee_err", "dd_err") else 1
        assert abs(ratio - expected) < 0.001
        assert abs((smaller[idx] - fitted[idx])/injected) < 0.001

    # A mirror inclination can occupy the same gap-dependent column as a
    # beam inclination. Keep the nominal mirror's point fixed, as in v9.
    for field, idx, name in (("sxz", 2, "X5"), ("syz", 7, "Y6"), ("sxy", 8, "Y7")):
        fitted = identify_case(field, 1e-4, 1e-4)
        print(f"mirror {field}: {name} [urad] {fitted[idx]*1e6:+.4f}, "
              f"X2/X3/Y2/Y3 deltas [mm]: {fitted[[0, 1, 5, 6]]}")
        assert abs(fitted[idx]/1e-4 + 1) < 0.001
