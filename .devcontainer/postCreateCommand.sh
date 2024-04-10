sudo apt update
sudo apt install bubblewrap -y
opam init --yes
eval $(opam env --switch=default)
echo 'test -r /home/vscode/.opam/opam-init/init.sh && . /home/vscode/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true' >> /home/vscode/.bash_profile
opam install dune ocaml-lsp-server ocamlformat --yes