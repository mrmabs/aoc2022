<?php
$f = fopen( 'php://stdin', 'r' );

$cwd = array();
$dirs = array(); # possibly track dirs in an ls
$ls = False;
$sizes = array();
#$actualsizes = array();


while( $line = fgets( $f ) ) {
    $tokenised = explode(" ", $line);
    #print_r ($tokenised);
    #print ($line);
    #print ($tokenised[0]);
    
    if ($tokenised[0] == "$") {
        $ls = False;
        $command = trim($tokenised[1]);
        if ($command == "cd") {
            #print("cd\n");
            $dir = trim($tokenised[2]);
            #print ("Dir: " . $dir);
            if ($dir == '/') {
                $cwd = array('/');
            } elseif ($dir == "..") {
                $x = array_pop($cwd);
            } else {
                array_push($cwd, $dir);
            }
        } elseif ($command == "ls") {
            #print("ls\n");
            $ls = True;
            $dirs = array();
        } 
    } elseif ($ls == True) {
        if ($tokenised[0] == "dir") {
            #print("ls - dir\n");
            array_push($dirs, trim($tokenised[1]));
        } else {
            #print("ls - file\n");
            $cwdname = join("/", $cwd);
            if(array_key_exists($cwdname, $sizes)) {
                $sizes[$cwdname] = $sizes[$cwdname] + trim($tokenised[0]);
                #$actualsizes[$cwdname] = $actualsizes[$cwdname] + trim($tokenised[0]);
            } else {
                $sizes[$cwdname] = trim($tokenised[0]);
                #$actualsizes[$cwdname] = trim($tokenised[0]);
            }
            for ($i = count($cwd); $i > 1; $i--) {
                #print ("Loop: " . $i);
            #}
            #if (count($cwd) > 1) {
                $cwdlen = $i; #count($cwd);
                #print ("Parent: " . count($cwd) . "\n");
                #print_r (array_slice($cwd, 0, $cwdlen - 1));
                $parent = join("/", array_slice($cwd, 0, $cwdlen - 1));
                if(array_key_exists($parent, $sizes)) {
                    $sizes[$parent] = $sizes[$parent] + trim($tokenised[0]);
                } else {
                    $sizes[$parent] = trim($tokenised[0]);
                }
                #$sizes[$parent] = $sizes[$parent] + trim($tokenised[0]);
            }
        }
                
        #print_r ($cwd);
        #print (join("/", $cwd) . "\n");
    }
}

$total    = 0;
$min      = 70000000;
$needfree = 30000000;
$used     = $sizes["/"];
$free     = ($min - $used);
$tofree   = $needfree - $free;
print ("Need to free: " . $tofree . "\n");

foreach ($sizes as $dir => $size) {
    print($dir . " => " . $size . "\n");
    if ($size <= 100000) {
        $total = $total + $size;
    }
    if ($size > $tofree) {
        if ($size < $min) {
            print("New Min: " . $size . "\n");
            $min = $size;
        }
    }
}
print ("Part 1: " . $total . "\n");
print ("Part 2: " . $min . "\n");
#print_r ($actualsizes);

fclose( $f );
?>
