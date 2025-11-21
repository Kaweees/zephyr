{
  mkShell,
  zephyr,
  callPackage,
  pkgs,
  lib,
}:

mkShell {
  packages = with pkgs; [
    clang # C++ compiler
    cppcheck # C++ linter
    cmake # CMake build system
    ninja # Ninja build system
    cmake-format # CMake format tool
    nixfmt # Nix formatter
    just # Just runner
    # (zephyr.sdk.override { targets = [ "arm-zephyr-eabi" ]; })
    zephyr.sdkFull
    zephyr.pythonEnv
    zephyr.hosttools-nix
    dfu-util
    picotool # PicoTool for debugging
    minicom # Minicom for serial communication
  ];

  # Shell hook to set up environment
  shellHook = ''
    export PATH=${zephyr.sdkFull}/arm-zephyr-eabi/bin:$PATH
    export PATH=${zephyr.pythonEnv}/bin:$PATH
    export PATH=${zephyr.hosttools-nix}/bin:$PATH
  '';
}
