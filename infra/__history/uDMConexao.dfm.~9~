object udmConexao: TudmConexao
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=db_tarefas'
      'User_Name=admin'
      'Password=123456'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 72
    Top = 64
  end
  object FDriver: TFDPhysMySQLDriverLink
    VendorLib = 'D:\To-Do List\Win32\Debug\libmysql.dll'
    Left = 72
    Top = 128
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 192
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 72
    Top = 288
  end
end
