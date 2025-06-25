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
  # =======================================
  # Example-DataSet
  # ---------------------------------------
  example = {
    string = "hello";
    integer = 1;
    float = 3.141;
    bool = true;
    null = null;
    list = [ 1 "two" false ];
    attribute-set = {
      a = "hello";
      b = 2;
      c = 2.718;
      d = false;
    };
  };

  ###################################################################
  # Names and Values
  ###################################################################
  # =======================================
  # let ... in ...
  # ---------------------------------------
  task1 = _:
    let
      x = 1;
      y = 2;
    in x + y;

  # =======================================
  # attribute set /list access
  # ---------------------------------------
  task2 = data:
    {
      "2a"= data.list; # output simple nested attribute
      "2b"= builtins.elemAt data.list 0; # output element from list - only via builtin function possible
      "2c"= data.attribute-set.a; # output even more nested attribute
    };

  # =======================================
  # with ...; ...
  # ---------------------------------------
  task3 = data:
    {
      "3a"= with data.attribute-set; [ a b c d]; #
    };


  # =======================================
  # inherit (...) ...
  # ---------------------------------------
  task4 = _:
    let
        # simple inherit
        subtask1 = _:
        let
            a.x = 1;
            a.y = 2;
        in
            {
                inherit a;
            };

        # referenced inherit
        subtask2 = _:
        let
            a.x = 1;
            a.y = 2;
        in
            {
                inherit (a) x y;
            };
    in
    {
        "4a" = subtask1 {};
        "4b" = subtask2 {};
    };

  # =======================================
  # String interpolation ${ ... }
  # ---------------------------------------
    task5 = _: {
    "5a" =
        let
        name = "Nix";
        in
        "hello ${name}";

    "5b" =
        let
        a = "no";
        in
        "A BIG ${a + " ${a + " ${a}"}"}";
    };


  # =======================================
  # Intented strings
  # File System Paths
  # Lookup Paths
  # ---------------------------------------
    task6 = _:
    ''
    ${toString /.} # root dir
    ${toString ../.} # parent dir

    ${<nixpkgs>}
    ${<nixpkgs/lib>}
    '';

  # =======================================
  #
  # ---------------------------------------

  tasks = {
    inherit task1;
    task2 =  _: task2 example;
    task3 =  _: task3 example;
    inherit task4 task5;
    inherit task6;
  };
in
  if taskName == "all" then
    builtins.mapAttrs (_: f: f {}) tasks
  else
    tasks.${taskName} {}
