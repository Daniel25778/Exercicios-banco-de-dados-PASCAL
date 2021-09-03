unit uSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TbrFmSobre = class(TForm)
    Panel1: TPanel;
    Panel4: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    lblP_text: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  brFmSobre: TbrFmSobre;

implementation

uses uAux;

{$R *.dfm}

procedure TbrFmSobre.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TbrFmSobre.FormCreate(Sender: TObject);
begin
lblP_text.Caption := 'brModelo (' + VersaoAtual + ') - Junho 2007.'#13 +
'+Modelo F�sico'#13 +
'+Undo/Rendo'#13 +
'+IR'#13 +
''#13 +
'brModelo (1.0.1)'#13 +
''#13 +
'Sistema para cria��o de diagrama conceitual/l�gico de banco de dados.'#13 +
'Constru�do como implementa��o da disserta��o de p�s-gradua��o'#13 +
'em banco de dados (Univag/UFSC) - Maio/2005.'#13 +
''#13 +
'Este sistema defende a metodologia abordada pelo Dr. Carlos A. Heuser'#13 +
'(ver s�rie de livro sobre o assunto) como sendo uma das mais abrangentes'#13 +
'para modelagem conceitual e visa, por meio dela, privilegiar'#13 +
'as decis�es do analista no momento da convers�o do modelo conceitual'#13 +
'para l�gico'#13 +
''#13 +
'Carlos Henrique C�ndido (ccandido@tre-mt.gov.br)'#13 +
'orientado por: Prof. Dr. Ronaldo (ronaldo@inf.ufsc.br)'#13 +
'100% Freeware';
end;

end.
