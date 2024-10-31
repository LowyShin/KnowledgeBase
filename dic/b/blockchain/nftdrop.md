自分が作成したNFTをユーザーに一気に配信したいと思ったらNFT Dropを利用するのもいいかと思います。

NFT Dropは沢山作ったNFTを登録してClaim Conditionを設定すると設定した時間からユーザーが取得できる仕組みです。

取得価格とかWallet一つに数量の制限などができて一気に配布してもアビューズ行為ができなく設定ができますね。

では早速作りましょうか？

1. Contract メニューをクリックして[+ Deploy contract]をクリックします。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/e8ab3aa3-d88c-42e8-8809-7b26ad27fd44)

2. PopularにあるNFT Dropを選択します。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/f737384b-8690-448d-bbb6-850e635c515e)

3. 詳細は分からないからそのまま[Deploy now >>]をクリックして早速作りましょう。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/ead440c2-628a-4c0c-bc87-fd7a49c79776)

4. Contractを作成するのはERC20と似てますが、Royaltiesというのがあって発行したNFTがどのように取引されても発行者にRoyaltyという利益が与えられます。
ほかにはERC20と同じなのでERC20編をご参考ください。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/fba39439-0bbd-4d3c-9bb1-67ed5c1b2f09)


5. NFTが作成されたら左側にNFTsメニューが表示されます。NFTsにNFTを登録しましょう。

- [+ Single Upload]を選択すると一つずつアップできます。
  - Name : NFT名を入力します。
  - Media : NFTの代表イメージを表示します。
  - Description : NFTの説明を入力します。
  - Properties : 無限に追加できますが、もしKey Value形式ではなくJSONなどの形式ならtrait_typeにdataと入力しvalueのところにファイルアップロードボタンをクリックしてファイル自体を登録することもできます。
  ![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/163e9e26-f40c-4b4c-b939-782863b18e1c)
- [Batch Upload]を選択するとフォーマットをダウンロードしてフォーマットに合わせて入力し一気にアップすることも可能です。
  ![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/f0f9ec88-0ffc-4e13-8dbc-01e9a20569fd)

6. 作成完了したらいつからもらえるかなどのCondition設定を行いましょう。

左メニューから[Claim Conditions]を選択します。

[+ Add Phase]をクリックして条件を登録します。クリックするとPublic, Public(With Allowlist), Allowlist Only, Only Ownerって表示されますが、誰でももらえるようにするために「Public」を選択しました。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/75c15135-6aa1-4c52-87c0-f160718f0b1a)

- Name : イベント名っていうかこのプロモーションのタイトルを記入します。
- When will this phase start? : 日時を入力するとその日時から配布が開始されます。
- How many NFTs will you drop in this phase : 今回のプロモーションでいくつのNFTを配布するかを数字で入力します。入力されたNFT数が超えたら終了する模様です。
- How much do you want to charge to claim each NFT? : 各NFTの価格を設定できます。無料なら０を入力すると無料配布できます。
- How many NFTs can be claimed per wallet? : 一人がたくさん申請することを防ぐために同じWalletにもらえるNFTが決まります。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/15a038d7-aa59-4a5a-b720-7999d9a2ab61)

[Save Phases]をクリックして保存すると準備は終わりました！

7. 次は時間になったらClaimを実行するAPIなどで呼び出すとオッケーですが、それからは開発ですね。頑張って！





