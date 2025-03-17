{
  description = "flake for the dev shell, to be used for the pg";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { 
        system = "x86_64-linux"; 
        config = {
          allowUnfree = true; 
          segger-jlink.acceptLicense = true;
          permittedInsecurePackages = [
            "segger-jlink-qt4-810"
          ];

        };
      };
      packageOverrides = pkgs.callPackage ./python-packages.nix {};
      python = pkgs.python3.override { inherit packageOverrides; };
    in
    {
      #devShells."x86_64-linux".default = import ./shell.nix { inherit pkgs; };
      devShells."x86_64-linux".default = pkgs.mkShell {
        packages = with pkgs; [
          nrf5-sdk
          nrfutil
          nrf-command-line-tools
          nrfconnect
          cmake
          ninja
          dtc
          gperf
          ccache
          dfu-util
          tk-8_5
          segger-jlink-headless
          segger-jlink
          zulu23
          nrf-udev

          (python.withPackages(p: with p; [
            anytree            
            appdirs            
            arrow              
            astroid            
            canopen            
#            capstone           
            cbor               
            certifi            
            cffi               
            charset-normalizer 
            click              
            cmsis-pack-manager 
            colorama           
            colorlog           
            coverage           
            cryptography       
            deprecated         
            dill               
            docopt             
            gcovr              
            gitdb              
            gitlint            
            gitpython          
            graphviz           
            idna               
            importlib-metadata 
            importlib-resources
            iniconfig          
            intelhex           
            intervaltree       
            isort              
            jinja2             
            junit2html         
            junitparser        
            lark               
            libusb1
            lpc-checksum       
            lxml               
            markupsafe         
            mccabe             
            mock               
            msgpack            
            mypy               
            mypy-extensions    
            natsort            
            packaging          
            pathspec           
            patool             
            pillow             
            pip                
            platformdirs       
            pluggy             
            ply                
            polib              
            prettytable        
            progress           
            psutil             
            pycparser          
            pyelftools         
            pygithub           
            pygments           
            pyjwt
            pykwalify          
            pylink-square      
            pylint             
            pynacl
            pyocd              
            pyserial           
            pytest             
            python-can         
            python-dateutil    
            python-magic       
            pyusb              
            pyyaml
            regex              
            requests           
            ruamel-base
            ruamel-yaml        
            ruamel-yaml-clib   
            ruff               
            semver             
            setuptools         
            sh                 
            six                
            smmap              
            sortedcontainers   
            sphinx
            tabulate           
            tomlkit            
            tqdm               
            typing-extensions  
            unidiff            
            urllib3            
            wcwidth            
            west               
            wheel              
            wrapt              
            yamllint           
            zipp               
          ]))
        ];

        shellHook = ''
          cd ~/nc/uni/5sem/pg/ble-framework
          zsh
        '';
      };

#          echo "================================================== \n
#                          DO NOT FORGET TO ENTER VENV \n
#                =================================================="
#          source ~/nc/uni/5sem/pg/ble-framework/.ble-venv/bin/activate

  };
}
