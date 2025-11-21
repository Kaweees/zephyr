# Out-of-tree drivers for custom classes
add_subdirectory_ifdef(CONFIG_BLINK blink)

# Out-of-tree drivers for existing driver classes
add_subdirectory_ifdef(CONFIG_SENSOR sensor)
