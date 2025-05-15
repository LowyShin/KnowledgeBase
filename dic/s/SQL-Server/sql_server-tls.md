SQL Server 2008에서 TLS 1.2를 활성화하려면 다음과 같은 단계를 따라야 합니다.

---

## 🔧 1. Windows 레지스트리에서 TLS 1.2 활성화
SQL Server 2008은 기본적으로 TLS 1.2를 지원하지 않으므로, 먼저 Windows에서 TLS 1.2를 활성화해야 합니다

1.`regedit`를 실행하여 레지스트리 편집기를 엽니다
2.다음 경로로 이동합니다

   ```
   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2
   ```


3.`TLS 1.2` 폴더 아래에 `Client`와 `Server`라는 두 개의 하위 키를 생성합니다
4. 각 하위 키에 다음과 같은 DWORD 값을 추가합니다:

   - `DisabledByDefault`:값을 `0`으로 설
   - `Enabled`:값을 `1`으로 설

   이 설정은 TLS 1.2를 클라이언트와 서버 모두에서 활성화합니다.

5.레지스트리 편집기를 종료하고 서버를 재부팅합니다

---

## 🛠️ 2. SQL Server 2008에 TLS 1.2 지원 추가
SQL Server 2008은 기본적으로 TLS 1.2를 지원하지 않으므로, Microsoft에서 제공하는 업데이트를 설치해야 합니.

- **SQL Server 2008 SP4** KB4057114 업데이트를 설치하여 TLS 1.2를 지원하도록 합니.

 다운로드 링:

  linkturn0search0

---

## ⚠️ 3. 클라이언트 드라이버 업데이트
SQL Server 2008에서 TLS 1.2를 사용하려면 클라이언트 측에서도 지원되는 드라이버를 사용해야 합니.

- **SQL Server Native Client 10.0** 최신 누적 업데이트를 설치하여 TLS 1.2를 지원하도록 합니.

 다운로드 링:

  linkturn0search0

---

## 📌 참고 사항
- 레거시 드라이버(예: `Provider=SQLOLEDB` 또는 `Driver={SQL Server}`)는 TLS 1.2를 지원하지 않으므로, 가능한 경우 최신 드라이버로 교체하는 것이 좋습다.
- 레지스트리 변경 시 시스템에 영향을 줄 수 있으므로, 변경 전에 반드시 레지스트리 백업을 권장합다.
- 업데이트 후에도 연결 문제가 발생할 경우, 클라이언트 애플리케이션의 TLS 설정을 확인하고 필요시 재구성해야 할 수 있습다.

--

자세한 내용은 Microsoft의 공식 문서를 참고하시기 바랍다.

linkturn0search0 