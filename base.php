

<?php

    require_once "functions.php";

    
    $dbh = null;
    
    try{

        // connect to database !
        $dsn = 'mysql:host=127.0.0.1;dbname=opium_test';
        $username = 'root';
        $password = '';
        $options = array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
        ); 
        $dbh = new PDO($dsn, $username, $password, $options);

        

        // pdo export database to a .sql file 
        

        // empty database : drop all tables ! 
        //dropAllTables($dbh);

        // execute file : new data !!
        //executeDBFiles($dbh, './1626913595.sql');
        //executeDBFiles($dbh, './db_text.sql');
        
        

    }catch(PDOException $e){
        print "Error!: " . $e->getMessage() . "<br/>";
        die();
    }

    if(isset($_POST['savefile'])) {
        $file = $_POST['filename'];
        if(!empty($file)){
            $tables = array();
            backup_tables($dbh, $tables, $file);
        }
    }
    if(isset($_POST['executedb'])) {
        $file = $_GET['fn'];
        if(!empty($file)){
            $file = $_GET['fn'];
            dropAllTables($dbh);
            executeDBFiles($dbh, './'.$file);
        }
    }  

    
    
   function showFiles(){
        foreach(glob('./*.sql') as $file) {
            echo '
                <tr>
                    <td>'.$file.'</td>
                    <td>
                        <form action="./base.php?fn='.$file.'" method="POST">
                            <button name="executedb" type="submit">Execute this file</button>
                        </form>
                        
                    </td>
                </tr>
            ';
        }
        
   }

    

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>
        <form action="./base.php" method="POST">
            <input type='text' name='filename' placeholder='File Name' />
            <button type='submit' name='savefile'>Enregistrer</button>
        </form>
    </div>
    <table border>
        <tr>
            <td>File Name</td>
            <td>Action</td>
        </tr>
        <?php showFiles(); ?>
    </table>

</body>
</html>