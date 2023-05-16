<?php

// en-têtes HTTP
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');

// on regarde la méthode HTTP pour "dispatcher" l'action
switch (strtolower($_SERVER['REQUEST_METHOD'])) {
    case 'get':
        // retourne la liste des tâches sous forme HTML
        getList();
        break;

    case 'post':
        // création ou mise à jour d'une tâche + retourne la tâche si OK
        post();
        break;
}

// retourne la liste des tâches
function getList()
{
    // récupération des tâches
    $tasks = getPDO()->query('SELECT * FROM tasks')->fetchAll(PDO::FETCH_ASSOC);
   // var_dump($tasks);

    // construction de la liste HTML des tâches
    $html = '<ul class="tasklist">';

    foreach ($tasks as $task) {
        $html .= '<li data-id="' . $task['id'] . '">';
        $html .= '<p>' . $task['title'] . '</p>';
        $html .= '<div class="delete"></div>';
        $html .= '<div class="edit"></div>';
    }

    $html .= '</ul>'; 

    echo $html;
}


function post()
{
    // récupération des données sous forme de tableau json
    $rawData = file_get_contents('php://input');

    $data = json_decode($rawData, true);

    switch ($data['action']) {
        case 'delete':
            return deleteTask($data['id']);

        case 'create':
            return createTask($data);

        case 'update' :
            return updateTask($data);
    }
}

// création d'une tâche
function createTask($data)
{
    $stmt = getPDO()->prepare('INSERT INTO tasks (title, status, updated_at) VALUES (:title, 1, CURRENT_TIMESTAMP())');
    $stmt->bindValue(':title', $data['title'], PDO::PARAM_STR);

    if (!$stmt->execute()) {
          header('HTTP/1.0 500 Internal Server Error');
          exit;
    }
 

    // affichage de la nouvelle tâche 

    $data['id'] = getPDO()->lastInsertId();
    $html = '<li data-id="' . $data['id'] . '">';
    $html .= '<p>' . $data['title'] . '</p>';
    $html .= '<div class="delete"></div>';
    $html .= '<div class="edit"></div>';
    echo $html;
}

// Mise à jour d'une tâche
function updateTask($data) 
{
    $stmt = getPDO()->prepare('UPDATE tasks SET title = :title  WHERE `id` = :id');
    $stmt->bindValue(':title', $data['title'] );
    $stmt->bindValue(':id', $data['id']);
    if (!$stmt->execute()) {
        header('HTTP/1.0 404 Not Found');
        exit;
    }
}

// suppression d'une tâche
function deleteTask($id)
{
    $stmt = getPDO()->prepare('DELETE FROM tasks WHERE id = :id');
    $stmt->bindValue(':id', $id, PDO::PARAM_INT);

    if (!$stmt->execute()) {
        header('HTTP/1.0 404 Not Found');
        exit;
    }
}


function getPDO()
{
    static $pdo;

    if (!$pdo) {
        $pdo = new PDO('mysql:host=localhost;dbname=todolist;charset=UTF8mb4', 'todolist', 'todolist');
    }

    return $pdo;
}
