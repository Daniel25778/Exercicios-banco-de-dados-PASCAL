unit uRegistraExten;

interface

uses Registry, ShlObj, SysUtils, Windows;

procedure RegisterFileType(cMyExt, cMyFileType, cMyDescription,
  ExeName: string; IcoIndex: integer; DoUpdate: boolean = false);

function jaRegistrado(cMyExt: string): boolean;
function brExecute(exe: string): Boolean;

implementation
uses ShellApi;

function brExecute(exe: string): Boolean;
begin
  Result := ShellExecute(0,'open',PChar(exe),nil,nil, SW_SHOWNORMAL)> 31;
end;

function jaRegistrado(cMyExt: string): boolean;
var
  Reg: TRegistry;
begin
  Result := false;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Result := Reg.OpenKey(cMyExt, false);
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

procedure RegisterFileType(cMyExt, cMyFileType, cMyDescription,
  ExeName: string; IcoIndex: integer; DoUpdate: boolean = false);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;

    // 1) Atribui a extens�o ao tipo de arquivo, criando
    //    a extens�o se ela j� n�o existir

    // Abre ou cria a chave HKCR\<cMyExt>
    Reg.OpenKey(cMyExt, True);
    // HKCR\.<cMyExt>\(Default)="<cMyFileType>"
    Reg.WriteString('', cMyFileType);
    Reg.CloseKey;

    // 2) Atribui a descri��o do tipo de arquivo, criando
    //    o tipo de arquivo se ele j� n�o existir

    // Abre ou cria a chave HKCR\<cMyFileType>
    Reg.OpenKey(cMyFileType, True);
    // HKCR\<cMyFileType>\(Default)="<cMyDescription>"
    Reg.WriteString('', cMyDescription);
    Reg.CloseKey;    // Now write the default icon for my file type

    // 3) Atribui o �ndice do �cone ao tipo de arquivo,
    //    criando a chave correspondente se ela j� n�o existir

    // Abre ou cria a chave HKCR\<cMyFileType>\DefaultIcon
    Reg.OpenKey(cMyFileType + '\DefaultIcon', True);
    // HKCR\<cMyFileType>\DefaultIcon\
    // (Default)="<cExeName>,<IcoIndex>"
    Reg.WriteString('', ExeName + ',' + IntToStr(IcoIndex));
    Reg.CloseKey;

    // 4) Escreve o comando para a a��o Abrir (Open) no Windows
    //    Explorer, criando a a��o se ela j� n�o existir

    // Abre ou cria a chave HKCR\<cMyFileType>\Shell\Open
    Reg.OpenKey(cMyFileType + '\Shell\Open', True);
    // HKCR\<cMyFileType>\Shell\Open\(Default)="&Open"
    Reg.WriteString('', '&Open');
    Reg.CloseKey;

    // 5) Define a aplica��o que ser� usada para executar a a��o,
    //    criando a chava correspondente se ela j� n�o existir

    // Abre ou cria a chave HKCR\<cMyFileType>\Shell\Open\Command
    Reg.OpenKey(cMyFileType + '\Shell\Open\Command', True);
    // HKCR\<cMyFileType>\Shell\Open\Command\
    // (Default)=""<cExeName>" "%1""
    // Sua aplica��o deve analisar os par�metros de linha de comando
    // para saber qual o arquivo passado
    Reg.WriteString('', '"' + ExeName + '" "%1"');
    Reg.CloseKey;

    // Finalmente, se voc� quiser que o Windows Explorer
    // reconhe�a o tipo de arquivo imediatamente, basta
    // chamar a API SHChangeNotify.
    if DoUpdate then
      SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  finally
    Reg.Free;
  end;
end;

end.

