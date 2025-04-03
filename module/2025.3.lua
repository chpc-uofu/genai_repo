-- -*- lua -*-
-- CHPC template for Container module file
-- modify only items noted
help(
[[
Any help you want to display when running "module help module-name"
]])

-- path to the container sif file
local CONTAINER="/uufs/chpc.utah.edu/sys/installdir/r8/genai/2025.3/genai-2025.3.sif"
-- text array of commands to alias from the container
local COMMANDS = {"python","jupyter","huggingface-cli"}
-- set to true if the container requires GPU(s)
local GPU = true

setenv("LLM_CACHE_PATH","/scratch/general/vast/app-repo/huggingface")
setenv("APPTAINER_LLM_CACHE_PATH","/scratch/general/vast/app-repo/huggingface")

-- these optional lines provide more information about the program in this module file
whatis("Name         : Miniconda with Pytorch and Transformers for Generative AI")
whatis("Version      : 2025.3")
whatis("Category     : Generative AI")
whatis("URL          : https://github.com/CHPC-UofU/genai_repo")
whatis("Installed on : 04/03/2025")
whatis("Installed by : Michael Ramshaw")

-- do not modify anything below this line
depends_on("apptainer")

if GPU then
  nvswitch = '--nv '
  add_property("arch","gpu")
  setenv("APPTAINER_NV","true")
else
  nvswitch = ''
end

local run_shell = 'apptainer shell ' .. nvswitch .. '-s /bin/bash ' .. CONTAINER
local run_function = CONTAINER .. " " 
-- set shell access to the container with "containerShell" command
set_shell_function("containerShell",run_shell,run_shell)

-- loop over COMMANDS array to create the shell functions
for ic,program in pairs(COMMANDS) do
  set_shell_function(program, run_function .. program .. " $@",run_function .. program .. " $*")
end

-- to export the shell function to a subshell
if (myShellName() == "bash") then
  execute{cmd="export -f containerShell",modeA={"load"}}
  execute{cmd="export -f " .. table.concat(COMMANDS, " "),modeA={"load"}}
-- newer Lmod unsets this automatically upon unload
-- execute{cmd="unset -f containerShell",modeA={"unload"}}
-- execute{cmd="unset -f " .. table.concat(COMMANDS, " "),modeA={"unload"}}
end



