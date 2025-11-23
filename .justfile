# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

alias b := build
alias r := run
alias t := test
alias c := clean
alias f := format
alias d := docs

# Default command when 'just' is run without arguments
default:
  @just --list

# Build the project
build *board='custom_plank':
  @mkdir -p build
  @echo "Configuring the build system..."
  @west update
  @echo "Building the project..."
  west build -p -b {{board}} app -- -DEXTRA_CONF_FILE=debug.conf

# Run a package
run:
  @west flash

# Run code quality tools
test:
  @echo "Running tests..."
  @./target/release/kiwicpp_tests

# Remove build artifacts and non-essential files
clean:
  @echo "Cleaning..."
  @find . -type d -name "build" -exec rm -rf {} +
  @find . -type d -name "external" -exec rm -rf {} +
  @find . -type d -name "twister-out" -exec rm -rf {} +

# Format the project
format:
  @echo "Formatting..."
  @chmod +x ./scripts/format.sh
  @./scripts/format.sh format
  @cmake-format -i $(find . -name "CMakeLists.txt")
  @find . -name "*.nix" -type f -exec nixfmt {} \;

# Generate documentation
docs:
  @echo "Generating documentation..."
  @cd doc && doxygen
