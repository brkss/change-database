<?php

    function dropAllTables($dbh){
            
        $index = 0;
        while($index < 6){
            $result = $dbh->query("SHOW TABLES");
            while ($row = $result->fetch(PDO::FETCH_NUM)) {
                //$tableList[] = $row[0];
                $dbh->prepare("DROP TABLE ".$row[0])->execute();
            }
            $index ++;
        }
    }

    function executeDBFiles($dbh, $filename){
        $file = file_get_contents($filename);
        try {
            $qr = $dbh->exec($file);
        }catch(PDOException $e){
            echo 'error';
        }
        
    }

    // function to backup all database tables to sql file
    function backupTables($DBH, $tables, $filename) {




        $DBH->setAttribute(PDO::ATTR_ORACLE_NULLS, PDO::NULL_NATURAL);

        //Script Variables
        $compression = false;
        $BACKUP_PATH = "";
        $nowtimename = time();

        //create/open files
        if ($compression) {
            $zp = gzopen($BACKUP_PATH . $nowtimename . '.sql.gz', "a9");
        } else {
            $handle = fopen($BACKUP_PATH . $filename . '.sql', 'a+');
        }

        // write headers 
        $header = '';
        $header .= 'SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";'."\n";
        $header .= 'SET AUTOCOMMIT = 0;'."\n";
        $header .= 'START TRANSACTION;'."\n";
        $header .= 'SET time_zone = "+00:00";'."\n";
        $header .= '/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;'."\n";
        $header .= '/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;'."\n";
        $header .= '/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;'."\n";
        $header .= '/*!40101 SET NAMES utf8 */;'."\n";
        $header .= '/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;'."\n";
        fwrite($handle, $header);

        //array of all database field types which just take numbers
        $numtypes = array('tinyint', 'smallint', 'mediumint', 'int', 'bigint', 'float', 'double', 'decimal', 'real');

        //get all of the tables
        if (empty($tables)) {
            $pstm1 = $DBH->query('SHOW TABLES');
            while ($row = $pstm1->fetch(PDO::FETCH_NUM)) {
                $tables[] = $row[0];
            }
        } else {
            $tables = is_array($tables) ? $tables : explode(',', $tables);
        }

        //cycle through the table(s)

        foreach ($tables as $table) {
            $result = $DBH->query("SELECT * FROM $table");
            $num_fields = $result->columnCount();
            $num_rows = $result->rowCount();

            $return = "";
            //uncomment below if you want 'DROP TABLE IF EXISTS' displayed
            //$return.= 'DROP TABLE IF EXISTS `'.$table.'`;';

            //table structure
            $pstm2 = $DBH->query("SHOW CREATE TABLE $table");
            $row2 = $pstm2->fetch(PDO::FETCH_NUM);
            $ifnotexists = str_replace('CREATE TABLE', 'CREATE TABLE IF NOT EXISTS', $row2[1]);
            $return .= "\n\n" . $ifnotexists . ";\n\n";

            if ($compression) {
                gzwrite($zp, $return);
            } else {
                fwrite($handle, $return);
            }
            $return = "";

            //insert values
            if ($num_rows) {
                $return = 'INSERT INTO `' . $table . '` (';
                $pstm3 = $DBH->query("SHOW COLUMNS FROM $table");
                $count = 0;
                $type = array();

                while ($rows = $pstm3->fetch(PDO::FETCH_NUM)) {
                    if (stripos($rows[1], '(')) {
                        $type[$table][] = stristr($rows[1], '(', true);
                    } else {
                        $type[$table][] = $rows[1];
                    }

                    $return .= "`" . $rows[0] . "`";
                    $count++;
                    if ($count < ($pstm3->rowCount())) {
                        $return .= ", ";
                    }
                }

                $return .= ")" . ' VALUES';

                if ($compression) {
                    gzwrite($zp, $return);
                } else {
                    fwrite($handle, $return);
                }
                $return = "";
            }
            $count = 0;
            while ($row = $result->fetch(PDO::FETCH_NUM)) {
                $return = "\n\t(";

                for ($j = 0; $j < $num_fields; $j++) {

                    //$row[$j] = preg_replace("\n","\\n",$row[$j]);

                    if (isset($row[$j])) {

                        //if number, take away "". else leave as string
                        if ((in_array($type[$table][$j], $numtypes)) && (!empty($row[$j]))) {
                            $return .= $row[$j];
                        } else {
                            $return .= $DBH->quote($row[$j]);
                        }
                    } else {
                        $return .= 'NULL';
                    }
                    if ($j < ($num_fields - 1)) {
                        $return .= ',';
                    }
                }
                $count++;
                if ($count < ($result->rowCount())) {
                    $return .= "),";
                } else {
                    $return .= ");";
                }
                if ($compression) {
                    gzwrite($zp, $return);
                } else {
                    fwrite($handle, $return);
                }
                $return = "";
            }
            $return = "\n\n-- ------------------------------------------------ \n\n";
            if ($compression) {
                gzwrite($zp, $return);
            } else {
                fwrite($handle, $return);
            }
            $return = "";
        }

        $error1 = $pstm2->errorInfo();
        $error2 = $pstm3->errorInfo();
        $error3 = $result->errorInfo();
        echo $error1[2];
        echo $error2[2];
        echo $error3[2];

        if ($compression) {
            gzclose($zp);
        } else {
            fclose($handle);
        }
    }