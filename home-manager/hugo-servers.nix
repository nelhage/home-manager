{
  pkgs,
  config,
  ...
}:
{
  launchd.agents =
    let
      logdir = "${config.home.homeDirectory}/Library/Logs";
    in
    {
      "hugo-notes" = {
        enable = true;
        config = {
          Label = "com.nelhage.hugo-notes";

          ProgramArguments = [
            "${pkgs.hugo}/bin/hugo"
            "serve"
            "-D"
            "--port"
            "1987"
            "--disableFastRender"
            "--destination"
            "_preview"
          ];

          WorkingDirectory = "${config.home.homeDirectory}/code/notebook";
          KeepAlive = true;
          RunAtLoad = true;

          StandardErrorPath = "${logdir}/hugo/notes-stdout.log";
          StandardOutPath = "${logdir}/hugo/notes-stderr.log";
        };
      };

      "hugo-blog" = {
        enable = true;
        config = {
          Label = "com.nelhage.hugo-blog";

          ProgramArguments = [
            "${pkgs.hugo}/bin/hugo"
            "serve"
            "-D"
            "-F"
            "cleanDestinationDir"
            "--disableFastRender"
            "--destination"
            "_preview"
          ];

          WorkingDirectory = "${config.home.homeDirectory}/code/blog.nelhage.com";
          KeepAlive = true;
          RunAtLoad = true;
          StandardErrorPath = "${logdir}/hugo/stdout.log";
          StandardOutPath = "${logdir}/hugo/stderr.log";
        };
      };
    };
}
