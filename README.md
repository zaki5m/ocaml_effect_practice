# ocaml_effect_practice
OCamlのエフェクトを使った練習用repository

## OCamlのセットアップ

**opamをinstal**

brewの場合は以下のコマンドを入力
```
brew install opam
```

**opamの初期化**

```
opam init
```
この直後に聞かれる内容は全部y(yes)でok
(カスタムしたければ各々やること)

**環境変数を更新**

初期化した後に以下のコマンドを実行する

今後，ocamlコンパイラのversionを変えたりした場合は，以下のコマンドを実行する必要がある

```
eval $(opam env)
```

**ocamlのversionを確認**

5.0.0以上あればok

```
opam switch
```
以下のように矢印の指している部分が現在のversion
```
→  5.0.0    ocaml-base-compiler.5.0.0   5.0.0
```

**もし5.0.0以上がinstallされていなかったら**

以下のコマンドで5.0.0をinstallする
```
opam switch create 5.0.0
```

**OCamlが正常に動くか確認**

REPLが動くか確認
```
ocaml
```

## 参照リンク集

- duneに関しては大体ここを見れば解決!!(https://dune.readthedocs.io/en/stable/reference/dune/index.html)

- effect handlerのexampleはここにいっぱい!!(https://github.com/ocaml-multicore/effects-examples)

- OCaml5のtutorial(https://github.com/ocaml-multicore/ocaml5-tutorial)

- OCamlのドキュメント"あまり参考にならない"(https://v2.ocaml.org/docs/)


