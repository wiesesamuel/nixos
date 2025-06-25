# comment:
#           learning based on https://nix.dev/tutorials/nix-language#names-and-values
# run nix files:
#           nix-instantiate --eval file.nix
#           nix-instantiate --eval --strict file.nix
# run this nix file:
#           nix-instantiate --eval --strict syntax_learning.nix  --argstr taskName task1
#           nix-instantiate --eval --strict syntax_learning.nix  --argstr taskName all
#           nix-instantiate --eval --strict --expr 'import ./syntax_learning.nix {}'


{ taskName ? "all" }:

let
  task1 = _: let
    x = 1;
    y = 2;
  in x + y;

  task2 = _: let
    x = 1;
    y = 2;
  in x * y;

  tasks = {
    inherit task1 task2;
  };
in
  if taskName == "all" then
    builtins.mapAttrs (_: f: f {}) tasks
  else
    tasks.${taskName} {}
