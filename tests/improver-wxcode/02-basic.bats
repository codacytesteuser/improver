#!/usr/bin/env bats
# -----------------------------------------------------------------------------
# (C) British Crown Copyright 2017-2018 Met Office.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

. $IMPROVER_DIR/tests/lib/utils

@test "wxcode <input files - decision tree units>" {
  TEST_DIR=$(mktemp -d)
  improver_check_skip_acceptance

  # Run wxcode processing and check it passes.
  run improver wxcode \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_rainfall_rate.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_rainfall_rate_in_vicinity.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_lwe_snowfall_rate.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_lwe_snowfall_rate_in_vicinity.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_visibility_in_air.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_cloud_area_fraction.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/probability_of_cloud_area_fraction_assuming_only_consider_surface_to_1000_feet_asl.nc" \
      "$TEST_DIR/output.nc"
  [[ "$status" -eq 0 ]]

  # Run nccmp to compare the output and kgo.
  improver_compare_output "$TEST_DIR/output.nc" \
      "$IMPROVER_ACC_TEST_DIR/wxcode/basic/kgo.nc"
  rm "$TEST_DIR/output.nc"
  rmdir "$TEST_DIR"
}
