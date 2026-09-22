{ lib, ... }:
{
  options = {
    user = {
      username = lib.mkOption {
        type = lib.types.singleLineStr;
        readOnly = true;
      };
      email = lib.mkOption {
        type = lib.types.singleLineStr;
        readOnly = true;
      };
    };
  };
}
