"""Reproduce the two first-order teaching examples in WTAF chapter 4.

Lengths in mm, angles in radians. The AA target is the local origin. The input
is synthetic. These calculations do not identify a machine's ten WTAF fields.
Run with Python 3 and NumPy: python wtaf_abbe_example_v1.py
"""
import numpy as np


def check_abbe_arms():
    # Hold one marked point at the AA target for separate ±Ry and ±Rx sweeps.
    # Order of the two columns is (X in the Ry sweep, Y in the Rx sweep).
    rotation = np.array([-100.0, 100.0]) * 1e-6
    true_arms = np.array([43.60, 32.65])
    old_arms = np.array([43.50, 32.50])
    directions = np.array([1.0, -1.0])
    upper_ranges = -np.outer(rotation, directions * true_arms)
    old_positions = upper_ranges + np.outer(rotation, directions * old_arms)
    slopes = (old_positions[1] - old_positions[0]) / (rotation[1] - rotation[0])
    new_arms = old_arms - directions * slopes
    new_positions = upper_ranges + np.outer(rotation, directions * new_arms)
    np.testing.assert_allclose(old_positions * 1e6, [[10, -15], [-10, 15]], atol=1e-8)
    np.testing.assert_allclose(new_arms, true_arms, rtol=0, atol=1e-12)
    np.testing.assert_allclose(new_positions, 0, rtol=0, atol=1e-13)
    print("Old positions [nm], rows -100/+100 urad, columns X/Y:\n", old_positions * 1e6)
    print("Residual slopes [mm/rad]:", slopes, "Updated arms [mm]:", new_arms)


def tilt_columns(x_baseline, y_baseline):
    # Each row is the derivative for a separate Rx, Ry, Rz excitation at zero.
    # 1-based columns of the v9 solver: X (2,3,5,6,8) and Y (2,3,6,7,8).
    x_rows = [[0, 0, 0, 0, 1],
              [1, 0, -x_baseline, 0, 0],
              [0, -1, 0, -x_baseline, 0]]
    y_rows = [[-1, 0, -y_baseline, 0, 0],
              [0, 0, 0, 0, 1],
              [0, 1, 0, -y_baseline, 0]]
    return np.array(x_rows, dtype=float), np.array(y_rows, dtype=float)


def check_two_positions():
    first = tilt_columns(120, 100)
    second = tilt_columns(300, 280)
    held_out = tilt_columns(207, 174)
    # Synthetic corrections. Columns 1, 2, 5 have length units; 3, 4 are
    # coefficients multiplying a baseline and an angle. Other v9 terms fixed.
    corrections = ([0.10, 0.14, 30e-6, -20e-6, 0.05],
                   [0.15, 0.09, -15e-6, 22e-6, 0.04])
    for axis, row_a, row_b, check, truth in zip("XY", first, second, held_out, corrections):
        design = np.vstack((row_a, row_b))
        norms = np.linalg.norm(design, axis=0)
        normalized = design / norms
        old_residual = -design @ truth
        scaled_fit, _, rank, _ = np.linalg.lstsq(normalized, -old_residual, rcond=None)
        fitted = scaled_fit / norms
        rank_one = np.linalg.matrix_rank(row_a)
        assert rank_one == 3 and rank == 5
        residual = check @ (fitted - truth)
        np.testing.assert_allclose(residual, 0, rtol=0, atol=1e-14)
        print(f"{axis}: ranks {rank_one} / {rank}, held-out slope residuals [mm/rad]:", residual)


if __name__ == "__main__":
    check_abbe_arms()
    check_two_positions()
