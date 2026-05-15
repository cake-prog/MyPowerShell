Write-Host "=== Windows Cleanup ==="      # выводит текст в консоль

$tempPath = $env:TEMP                     # в переменную $tempPath мы кладем системную переменную $env в которой будет путь до папки TEMP с временными файлами пользователя

Write-Host "TEMP папка: $tempPath"                


Get-ChildItem $tempPath -Recurse -Force -ErrorAction SilentlyContinue |
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

#   -Recurse - удаляет вложенные папки и файлы
#   -Force - удаляет скрытые файлы и папки
#   -ErrorAction SilentlyContinue - игнорирует ошибки (некоторые TEMP-файлы заняты системой и не удалятся без этого)
#
#   с помощью | (pipe) мы передаем результат левой команды правой Get-ChildItem -> Remove-Item
#   
#   мы как бы захватываем вложенные, скрытые и системные фалйлы и папки -> передаем их Remove-Item где удаляем их
#
#

Write-Host "Готово"