"""Check the Y equation in the two user-supplied WTAF photographs.

The test holds the other inputs fixed within each rotation pair. Lengths are
in one consistent example unit and angles in radians. It tests the printed
expression, without assigning a physical origin or a unit to its 0.1314 offset.
Run: python outputs/code/wtaf_photo_y_check_v1.py
"""
import numpy as np


def value_and_gradient(s, angles, theta):
    # s groups y and the mean of the two upper-beam inputs in the photograph.
    # The last additive length term is held at zero; it has no parameter derivative.
    alpha, beta, gamma = angles
    ly, dd, ay, rxiy0, rziy0 = theta
    p = s - ly
    d = dd - 0.1314
    u = alpha - rxiy0
    f = p * (1 - u*u/2) - d * (u*beta - (gamma - rziy0)) + ay*u
    jac = np.array([-1 + u*u/2, -u*beta + gamma - rziy0, u,
                    p*u + d*beta - ay, -d])
    return f, jac


def ranked(matrix):
    # Scale the nonzero columns before judging rank. Matrix contains only
    # analytical parameter derivatives; no truncation threshold in physical units.
    matrix = np.asarray(matrix)
    norms = np.linalg.norm(matrix, axis=0)
    active = norms > 0
    return np.linalg.matrix_rank(matrix[:, active]/norms[active])


def main():
    theta = (125., .40, 32.5, 150e-6, -70e-6)
    ly, dd, ay, r, t = theta
    d = dd - .1314
    step = 500e-6
    absolute, odd, even = [], [], []
    for s in (200., 390.):
        p = s - ly
        v0, j0 = value_and_gradient(s, np.zeros(3), theta)
        absolute.append(j0)
        expected_slopes = (ay + p*r, d*r, d)
        for axis, angle in enumerate(step * np.eye(3)):
            vp, jp = value_and_gradient(s, angle, theta)
            vm, jm = value_and_gradient(s, -angle, theta)
            absolute.extend((jp, jm))
            odd.append((jp-jm)/(2*step))
            even.append((jp+jm)/2-j0)
            np.testing.assert_allclose((vp-vm)/(2*step), expected_slopes[axis], rtol=0, atol=1e-10)
            expected_even = -p * step**2/2 if axis == 0 else 0
            np.testing.assert_allclose((vp+vm)/2 - v0, expected_even, rtol=0, atol=1e-12)
        # Changing t shifts every sample by exactly the same constant.
        other = (ly, dd, ay, r, t + .001)
        for angles in (np.zeros(3), np.array([step, -step, step])):
            delta = value_and_gradient(s, angles, other)[0] - value_and_gradient(s, angles, theta)[0]
            np.testing.assert_allclose(delta, -d*.001, rtol=0, atol=1e-12)
        print(f"P={p:g}: angular slopes = {expected_slopes}, even alpha = {-p*step**2/2:+.9g}")
    # For finite step, subtracting nominally equal floating-point columns can
    # introduce small spurious singular values. Rebuild the identical Jacobian
    # row combinations analytically to check the cancellation at machine precision.
    clean_odd = []
    clean_even = []
    for s in (200., 390.):
        clean_odd.extend(([-r,0,1,s-ly,0], [0,r,0,d,0], [0,1,0,0,0]))
        clean_even.extend(([step**2/2,0,0,0,0], [0]*5, [0]*5))
    np.testing.assert_allclose(odd, clean_odd, rtol=1e-9, atol=2e-11)
    np.testing.assert_allclose(even, clean_even, rtol=1e-9, atol=2e-13)
    ranks = [ranked(clean_odd), ranked(clean_odd+clean_even), ranked(absolute)]
    assert ranks == [3, 4, 5]
    absolute_with_unknown_zero = np.column_stack((absolute, np.ones(len(absolute))))
    assert ranked(absolute_with_unknown_zero) == 5  # six unknowns, one gauge freedom
    print("Ranks: odd / odd+even / anchored absolute =", ranks)


if __name__ == "__main__":
    main()
