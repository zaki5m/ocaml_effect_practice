# ocaml_effect_practice
OCamlのエフェクトを使った練習用repository
`src/`の中にライフゲームを作ることが最終目標！！

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

## OCamlの実行方法
OCamlコードをコンパイルする方法はいくつかあるのですが，`dune`というbuildツールを使用しておかないと大きなものを作るときは面倒なので，初めからduneだけ使えるようになっておこう！

### ライブラリのinstall(dune)
まずは，duneをinstallしましょう

```
opam install dune
```

このほかにもライブラリをinstallするときは，`dune`の部分をライブラリ名に変えるとinstallできます．
(ちょっといいREPLとしてutopを入れておくことをオススメします)

### duneを用いたOCamlコードの実行①
**buildを行う**
```
dune build
```

**実行する**
```
./_build/default/src/main.exe
```

### duneを用いたOCamlコードの実行②
**buildと実行を行う**
```
dune exec main
```

⚠️この実行方法を行いたかったらduneの設定を若干ちゃんとする必要があります．

### duneの書き方

**dune**

duneという名前のfileの中に，buildに関することを書く必要があります．

また，duneという名前のfileは各ディレクトリにつき1つ必要です(これがクソ仕様なんだよな)

executableから始まるものは実行するためのfileを指します．(今回はほとんどこれを使うと思います)

testを書きたい場合はそのためのduneの書き方もあるのですが，今回は省略します.(後で追記するかも)


以下にexcutableの要素について説明
- name: 実行したいコードのroot fileの名前
- modules: このコードを実行するために必要なmoduleの列挙(スペース区切りで)
- public_name: `dune exec public_name`の部分を決めることができる．②の実行に必要．(省略可能)
- libraries: 外部libraryを使用するときはここに列挙
```
(executable
 (name main)
 (modules main)
 (public_name main))
```

**dune-project**

プロジェクトのルートにdune-projectという名前のfileを作る必要がある

中身については，基本的に1行記載していればok
```
(lang dune 3.0)
```

## Effectに関して

[Deep Effect](https://github.com/zaki5m/blob/main/deep_example.ml)と[Shallow Effect](https://github.com/zaki5m/blob/main/shallow_example.ml)を使った，状態管理の例をそれぞれ`example/`においています．ぜひ参考にしてください．

試しに，以下を実行して同じものが出るか確認してください．
```
dune build
```

```
./_build/default/example/deep_example.exe
1
3
```

```
./_build/default/example/shallow_example.exe
1
3
```

困ったことがあればなんでも聞いてください！

## 参照リンク集

- duneに関しては大体ここを見れば解決!!(https://dune.readthedocs.io/en/stable/reference/dune/index.html)

- effect handlerのexampleはここにいっぱい!!(https://github.com/ocaml-multicore/effects-examples)

- OCaml5のtutorial(https://github.com/ocaml-multicore/ocaml5-tutorial)

- OCamlのドキュメント"あまり参考にならない"(https://v2.ocaml.org/docs/)


