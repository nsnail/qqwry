$types = @{
    '1' = @('major', '主版本')
    '2' = @('minor', '此版本')
    '3' = @('patch', '修订版本')
}
$prefix = ''
while ($null -eq $types[$prefix])
{
    $prefix = Read-Host "请选择版本类型`n" $( & { param($i) $i | ForEach-Object { "$_ : $( $types[$_][0] )（$( $types[$_][1] )）`n" } } $types.Keys | Sort-Object )
}
git branch -d release
git checkout -b release
../node_modules/.bin/standard-version -r $prefix
git push --follow-tags --force origin release
Start-Process -FilePath "https://github.com/nsnail/QQWry.Net.git/compare/main...release"