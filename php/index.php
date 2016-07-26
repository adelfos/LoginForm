<?php

try {

    $loader = new \Phalcon\Loader();
    $loader->registerDirs(array(
        __DIR__.'/models/'
    ))->register();

    $di = new \Phalcon\DI\FactoryDefault();


    $di->set('db', function(){
        return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
            "host"     => "localhost",
            "username" => "flex",
            "password" => "*******",
            "dbname"   => "adelfos-juliana0_flex"));
    });

    $app = new \Phalcon\Mvc\Micro($di);



// Adds a new user
    $app->post('/api/users', function() use ($app) {

        $user = $app->request->getJsonRawBody();

        $phql = "INSERT INTO Users (login, pass, email, name, surname) VALUES (:login:, :pass:, :email:, :name:, :surname:)";

        $status = $app->modelsManager->executeQuery($phql, array(
            'login' => strtolower($user->login),
            'pass' => $user->pass,
            'email' => $user->email,
            'name' => $user->name,
            'surname' => $user->surname
        ));

        $response = new Phalcon\Http\Response();

        if ($status->success() == true) {

            $response->setStatusCode(201, "Created");
            $user->id = $status->getModel()->id;
            $response->setJsonContent(
                array(
                    'status' => 'OK',
                    'data'   => $user));
        } else {
            $errors = array();
            foreach ($status->getMessages() as $message) {
                if(strlen($message->getMessage()) > 0)
                    $errors[] = $message->getMessage();
            }

            $response->setJsonContent(
                array(
                    'status' => 'ERROR',
                    'message' => $errors,));
        }

        return $response;
    });

// Login.
     $app->post('/api/authentication', function() use ($app) {
         $user = $app->request->getJsonRawBody();

         $phql = "SELECT * FROM  Users WHERE login = :login: AND pass = :pass: ";
         $user = $app->modelsManager->executeQuery($phql, array(
             'login' => strtolower($user->login),
             'pass' => $user->pass
         ))->getFirst();

         $response = new Phalcon\Http\Response();

         if ($user == false) {
             $response->setJsonContent(array('status' => 'NOT-FOUND',
                 'message'=> 'Пользователь не найден'));
         } else {
             $response->setJsonContent(array(
                     'status' => 'OK',
                     'data' => $user));
         }
         return $response;
     });

    $app->handle();

} catch (\Phalcon\Exception $e) {
    $response = new Phalcon\Http\Response();
    $response->setJsonContent(array(
            'status' => 'ERROR',
            'message' => "PhalconException: ", $e->getMessage()));
    return $response;
}

