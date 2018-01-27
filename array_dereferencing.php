<?php

function highSchedule() {
    return [
        ['min' => 0, 'max' => 1], // Hour 0 (12 am)
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 2],
        ['min' => 0, 'max' => 2],
        ['min' => 1, 'max' => 3],
        ['min' => 1, 'max' => 4],
        ['min' => 1, 'max' => 4],
        ['min' => 2, 'max' => 5], // Hour 12 pm
        ['min' => 1, 'max' => 4],
        ['min' => 1, 'max' => 3],
        ['min' => 1, 'max' => 3],
        ['min' => 0, 'max' => 2],
        ['min' => 0, 'max' => 2],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1],
        ['min' => 0, 'max' => 1], // Hour 23 (11pm)
    ];
}
// Can't modify original array
highSchedule()[12]['min'] = 'asdf';
unset(highSchedule()[12]['max']);
echo highSchedule()[12]['min'] . "\n";
echo highSchedule()[12]['max'] . "\n";

function foobar(){
    return explode(' ', 'zero one two three four five');
}
echo foobar()[2] . "\n";
echo foobar()[count(foobar()) - 1] . "\n";
echo array_search('two', foobar()) . "\n";

foreach(highSchedule() as $hour) {
    echo $hour['min'].", ".$hour['max']."\n";
}
echo "\n";

$i = 9;
for($i; $i <= 15; $i+=1) {
    echo $i." => ".highSchedule()[$i]['min'].", ".highSchedule()[$i]['max']."\n";
}
