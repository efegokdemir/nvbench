# By default, add dependent DLLs to the build directory on Windows. This
# avoids runtime lookup failures for NVML, CUPTI, and their dependencies.
if (WIN32 AND MSVC)
  option(NVBench_ADD_DEPENDENT_DLLS_TO_BUILD
    "Copy dependent DLLs to the NVBench build directories."
    ON
  )
else()
  # TARGET_RUNTIME_DLLS is only useful for Windows DLL targets. Keep the
  # option disabled elsewhere so this helper has no effect on other platforms.
  set(NVBench_ADD_DEPENDENT_DLLS_TO_BUILD OFF)
endif()

function(nvbench_setup_dep_dlls target_name)
  # The custom command fails when there are no runtime DLLs to copy, so only
  # enable it when a runtime dependency is configured for the target.
  if (NVBench_ADD_DEPENDENT_DLLS_TO_BUILD AND
      (NVBench_ENABLE_NVML OR NVBench_ENABLE_CUPTI))
    add_custom_command(TARGET ${target_name}
      POST_BUILD
      COMMAND "${CMAKE_COMMAND}" -E copy
        "$<TARGET_RUNTIME_DLLS:${target_name}>"
        "$<TARGET_FILE_DIR:${target_name}>"
      COMMAND_EXPAND_LISTS
    )
  endif()
endfunction()
