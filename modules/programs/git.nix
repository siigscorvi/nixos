{ vars, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "<c-v>";
          context = "global";
          description = "Create new conventional commit";
          prompts = [
            {
              type = "menu";
              key = "Type";
              title = "Type of change";
              options = [
                { name = "build"; description = "Changes that affect the build system or external dependencies"; value = "build"; }
                { name = "feat";  description = "A new feature";                                    value = "feat"; }
                { name = "fix";   description = "A bug fix";                                       value = "fix"; }
                { name = "chore"; description = "Other changes that don't modify src or test files"; value = "chore"; }
                { name = "ci";    description = "Changes to CI configuration files and scripts";    value = "ci"; }
                { name = "docs";  description = "Documentation only changes";                       value = "docs"; }
                { name = "perf";  description = "A code change that improves performance";           value = "perf"; }
                { name = "refactor"; description = "A code change that neither fixes a bug nor adds a feature"; value = "refactor"; }
                { name = "revert";   description = "Reverts a previous commit";                   value = "revert"; }
                { name = "style";    description = "Changes that do not affect the meaning of the code"; value = "style"; }
                { name = "test";     description = "Adding missing tests or correcting existing tests"; value = "test"; }
              ];
            }
            { type = "input"; title = "Scope"; key = "Scope"; initialValue = ""; }
            {
              type = "menu";
              key = "Breaking";
              title = "Breaking change";
              options = [ { name = "no";  value = ""; } { name = "yes"; value = "!"; } ];
            }
            { type = "input"; title = "Summary"; key = "Summary"; initialValue = ""; }
            { type = "input"; title = "Description"; key = "Description"; initialValue = ""; }
            { type = "confirm"; key = "Confirm"; title = "Commit"; body = "Are you sure you want to commit?"; }
          ];
          command = "git commit --message '{{.Form.Type}}{{ if .Form.Scope }}({{ .Form.Scope }}){{ end }}{{.Form.Breaking}}: {{.Form.Summary}} -m {{.Form.Description}}'";
          loadingText = "Creating conventional git commit...";
        }
      ];
    };
  };

  home-manager.users.${vars.username} = {

    programs.git = {
      enable = true;
      userEmail = "${vars.unimail}";
      userName = "${vars.gitusername}";
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        url = {
          "ssh://git@github.com:siigscorvi" = {
            insteadOf = "https://github.com/siigscorvi";
          };
        };
      };
    };

  };
}
