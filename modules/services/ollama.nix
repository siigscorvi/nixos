{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen2.5-coder:7b" "qwen2.5-coder:1.5b"  ];
    acceleration = "cuda";
  };
}
