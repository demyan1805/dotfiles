# Defined in /var/folders/gg/s159wbtx1014w775zwkbdx4r0000gn/T//fish.phSObV/poetry_shell.fish @ line 1
function poetry_shell
	source (dirname (poetry run which python))/activate.fish
end
