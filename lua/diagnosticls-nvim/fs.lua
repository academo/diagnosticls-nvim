local M = {}

-- Check if the file in the filepath exist
local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Get the node executable if it exists
-- in node_modeles, else use the global executable
local function get_node_executable(command)
  local project_command = vim.fn.getcwd() .. '/node_modules/.bin/' .. command
  if file_exists(project_command) == true then
    command = project_command
  end

  return command
end

-- Get the exactly location of the binary to run
-- based on the type of environment
M.get_executable = function(command, type)
  if command == nil then
    vim.api.nvim_err_writeln('[diagnosticls-nvim] "command" is required')
    return
  end

  if type == nil then
    return command
  end

  -- pattern matching
  local get_executable_by_type = {
    node = get_node_executable
  }

  command = get_executable_by_type[type](command)
  return command
end

return M