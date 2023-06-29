## Windows Common

- [SenseNDR.exe、例外コード:0xc0000005](sensendr.md)

- [【Bginfo】Windowsのデスクトップにシステム情報を表示する方法と各種カスタマイズ](https://mugendennou.net/win-server/bginfo/)

- [EvetCreate.exe(official)](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/eventcreate)

### C드라이브 압박시 대처방법

- 크롬 템프 디렉토리의 이동
  - 크롬을 종료(태스크 매니저에 크롬 관련 뜬거 모두 종료)1. Shut down Chrome. Then open Task Manager and check the processes and make sure the Chrome process is not running. Just closing Chrome doesn't always shut down the Chrome process, and if it's running, it will lock certain files that you need to move in the next step.
 
2. Create a directory at some suitable location where you want the cache to go, for example D:\Chrome Cache and Profile.
 
3. Navigate to where Chrome is installed, and move the entire "User Data" directory into this new directory you created in the previous step. The User Data directory is usually found at C:\Users\{username}\AppData\Local\Google\Chrome\User Data. Just move the whole User Data directory to the new location. So now in the new location you'll have a User Data directory, like so "D:\Chrome Cache and Profile\User Data". And the User Data directory will be gone from the original location, because you moved it.
 
4. Next, open an elevated command prompt (right click the command prompt icon and choose "Run as Administrator"). In the command window, type:
 
mklink /J "C:\Users\{username}\AppData\Local\Google\Chrome\User Data" "D:\Chrome Cache and Profile\User Data"
 
Make sure to replace the {username} with your own user account name. Don't leave out the quotes, they are necessary.
 
That's it. Next time you start Chrome, it will store all files related to your profile (including cache) at the new location.

## Windows Server

- [2022 年(KB894199) のコンテンツにおけるソフトウェア更新サービスとWindows Server Update Servicesの変更について](https://support.microsoft.com/ja-jp/topic/description-of-software-update-services-and-windows-server-update-services-changes-in-content-for-2022-kb894199-0c540f4f-60c8-7dc2-23c9-48153749966d#bkmk_ref)
- [Software Update Services および Windows Server Update Services におけるコンテンツの変更について (2021 年)](https://support.microsoft.com/ja-jp/topic/software-update-services-%E3%81%8A%E3%82%88%E3%81%B3-windows-server-update-services-%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%B3%E3%83%B3%E3%83%86%E3%83%B3%E3%83%84%E3%81%AE%E5%A4%89%E6%9B%B4%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6-2021-%E5%B9%B4-272c014b-b9a5-4234-93c2-b7214af3f57f)
- [Windows update 関連情報](https://support.microsoft.com/ja-jp/topic/software-update-services-%E3%81%8A%E3%82%88%E3%81%B3-windows-server-update-services-%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%B3%E3%83%B3%E3%83%86%E3%83%B3%E3%83%84%E3%81%AE%E5%A4%89%E6%9B%B4%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6-2021-%E5%B9%B4-272c014b-b9a5-4234-93c2-b7214af3f57f#bkmk_ref)
 
## Windows 10

* Official download
  * https://www.microsoft.com/ko-kr/software-download/windows10

* [【2020年版】Edgeの各種設定に対応するレジストリを紹介](https://gyoumu-kouritsuka-pro.site/edge-reg/)



