{
  ...
}:
{
  environment.etc = {
    "brave/policies/managed/org-protocol.json" = {
      text = ''
        {
        "AutoLaunchProtocolsFromOrigins": [
            "allowed_origins": [ "*" ],
            "protocol": "org-protocol"
          ]
        }
      '';
    };
  };
}
