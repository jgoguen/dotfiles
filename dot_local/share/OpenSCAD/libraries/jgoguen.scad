// jgoguen.scad
// Copyright (c) 2025 jgoguen
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module xor() {
  assert($children == 2, "xor2() requires exactly two children");

  union() {
    difference() {
      children(0);
      children(1);
    }
    difference() {
      children(1);
      children(0);
    }
  }
}

// Helper: Triangle wave
function triangle_wave(x, wavelength = 20) =
  4 * abs((x / wavelength) - floor(x / wavelength + 0.5)) - 1;

// Unified module for a wavy wall with optional vertical waves or circular arc.
module wavy_wall(
  length = 100, // If radius > 0, this is the arc length
  height = 30,
  thickness = 5,
  amplitude = 10,
  wavelength = 20,
  resolution = 100,
  alternating = false,
  asymmetric_skew = 0,
  vertical_amplitude = 0,
  vertical_wavelength = 60,
  radius = 0 // 0 gives a straight wall, >0 gives a curved wall
) {
  step = length / resolution;

  // Generate base 2D wave shape
  base_points = [
    for (x = [0:step:length]) [
      x,
      amplitude * (
        alternating ? triangle_wave(x, wavelength)
        : sin(360 * x / wavelength) * (
          asymmetric_skew > 0 ? pow(abs(sin(180 * x / length)), asymmetric_skew)
          : 1
        )
      ),
    ],
  ];

  // Are we making a circular arc?
  shape_points =
    radius > 0 ? [
        for (p = base_points) let (
          arc_angle = 360 * p[0] / (2 * PI * radius)
        ) [
            radius * cos(arc_angle),
            radius * sin(arc_angle) + p[1],
        ],
      ]
    : base_points;

  if (vertical_amplitude == 0) {
    // Flat top
    linear_extrude(height=height) {
      offset(delta=thickness / 2) {
        offset(delta=-thickness / 2) {
          polygon(shape_points);
        }
      }
    }
  } else {
    // Simplified approximation of a vertical wave
    for (i = [0:len(shape_points) - 2]) {
      p1 = shape_points[i];
      p2 = shape_points[i + 1];

      x = i * step;
      h1 = height + vertical_amplitude * sin(360 * x / vertical_wavelength);
      h2 = height + vertical_amplitude * sin(360 * (x + step) / vertical_wavelength);

      linear_extrude(height=(h1 + h2) / 2) {
        polygon([p1, p2, [p2[0], p2[1] + 0.001], [p1[0], p1[1] + 0.001]]);
      }
    }
  }
}
