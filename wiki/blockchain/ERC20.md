トークンを作成するツールはnodeベースのtruffle, openzeppelinなど多いですが、今回はWebで簡単に作成できるThirdWebというツールを利用させていただきます。

- [Thirdweb](https://thirdweb.com/)


### Create ERC-20 Token Contract

独自トークンを発行してサービスに使いたい場合ERC20トークンを作成すると良いです。
PolygonもEVM Compatibilityに合ってるのでEthereum Walletの自分のアドレスをそのまま使えます。但し、PolygonネットワークがサポートされているWalletのみですね。

まずContractを作成しましょう。

- [+ Deploy contract]をクリック
![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/45e1c4d3-a0f2-4a1c-8e95-c8426034f830)

- ERC20 Standardと書いてあるトークンを選択します。
![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/52f11b90-9c48-4978-abec-dd6d33f709ea)

- 詳細がありますが、全て含まれているのでそのまま[Deploy now >>]をクリックしましょう。
![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/2522b6f5-a2d1-45e8-a701-d61a4fa7de70)

- イメージをアップしなくても良いですが、好きなロゴがあったらアップしてください。
- Nameにはトークンの正式名称を入れましょう。
- SymbolにBTCとかETHなどの縮約した記号を入れます。
- Descriptionにはこのトークンの詳細を入れましょう。公式ホームページがあったら入れた方がいいでしょう。
- Primary Sale Recipientには自分のWallet Addressを入れといたら最初発行する時自分に来ます。
- 終わったら下のネットワークを選択します。今回はPolygonのテストネットのMUNBAIを選択しました。
![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/1152ca41-04d4-4f20-bcfc-4fbeaff92d4b)
- 終わったら[Deploy Now]をクリックすると生成完了！

- 生成が終わったらContractsメニューから生成されたトークンが表示されます。
- まだ完成と書いてないでしょう。それはまだMintされてないからです。
- 作成したContractをクリックすると左のExtensionsにTokensメニューが表示されます。クリックしてみましょう。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/cbf6160a-a63c-4f0b-a954-e363c88d72c5)

[+ Mint]をクリックして発行量を決めましょう。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/9c2b4b4d-2ed3-4157-9f22-11ca7abf7922)

好きなほど入れましょう。

すると発行量が発行されたことが分かります。

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/8a0a03eb-8ecb-4648-b9fb-7f59bc51a287)

polygonscanから見てみましょうか？

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/b70b8a97-5a23-4e4a-b0f0-16c2c85b7f74)

Contractの詳細が表示されます。
よくわからなかったら右にあるToken Trackerに表示されている自分のトークンをクリックしてみましょうか？

Total Supplyに正常に自分がMintした数量が表示されましたね！

![image](https://github.com/LowyShin/KnowledgeBase/assets/20239203/bdced13e-382e-4dfa-b73e-2333ee833188)

これで成功です！

知り合いに伝送したいならTokensメニューから[Transfer]を利用して友達にあげてみましょう！



