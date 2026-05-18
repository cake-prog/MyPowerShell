
Write-Host "=== Windows Cleanup ==="      # выводит текст в консоль
$startTime = Get-Date

$tempPath = $env:TEMP                     # в переменную $tempPath мы кладем системную переменную $env в которой будет путь до папки TEMP с временными файлами пользователя

Write-Host "TEMP папка: $tempPath"                


$files = Get-ChildItem $tempPath -Recurse -Force -File -ErrorAction SilentlyContinue
$totalSize = ($files | Measure-Object Length -Sum).Sum
$totalSizeMB = [math]::Round($totalSize / 1MB, 2)

#
# Measure-Object — Возьми у каждого объекта свойство Length и сложи его
# Length — свойство файла (размер файла в байтах)
# -Sum — сложить все значения
# .Sum — взять итоговую сумму
# т.е. Measure-Object берет свойство Length и суммирует его -Sum
# у обекта есть свойство .Sum 

$files | Remove-Item -Force -ErrorAction SilentlyContinue

Get-ChildItem $tempPath -Directory -Recurse -Force -ErrorAction SilentlyContinue |
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
$endTime = Get-Date
$executionTime = $endTime - $startTime  # $executionTime формата часы:минуты:секунды.миллисекунды


Write-Host "Готово"

Write-Host "Время выполнения: $executionTime"

Write-Host "Освобождено: $totalSizeMB MB"
