from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt
import os

# Usando a URI diretamente da variável de ambiente
mongo_uri = os.getenv("MONGO_URI", "mongodb+srv://qa:xperience@cluster0.pnoc5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")

try:
    client = MongoClient(mongo_uri)
    db = client['test']
    print("Conexão com o MongoDB estabelecida com sucesso.")
except Exception as e:
    print(f"Erro ao conectar ao MongoDB: {e}")


# # Usando a URI diretamente da variável de ambiente
# client = MongoClient('mongodb+srv://qa:xperience@cluster0.pnoc5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

# db = client['test']


@keyword('Clean user from database')
def clean_user(user_email):

    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})

    if (u):
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})
    else:
        print(f'Usuário com email {user_email} não encontrado.')

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert user from database')
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }

    # Codifica a senha em UTF-8 e converte para string para poder concatenar
    senha_utf8 = user['password'].encode('utf-8').decode('utf-8')
    print('Senha em UTF-8: ' + senha_utf8)

    # Converte o hash para string, se necessário
    print('Código hash: ' + str(hash_pass))

    users = db['users']
    users.insert_one(doc)

    print(user)
    print(doc)

# @keyword('Remove task from database')
# def remove_user_task(email, task):
#     users = db['users']
    
#     # Atualiza o usuário, removendo a tarefa específica do array de tarefas
#     result = users.update_many(
#         {'email': email},  # Filtra o usuário pelo email
#         {'$pull': {'tasks': task}}  # Remove a tarefa do array 'tasks'
#     )
    
#     if result.modified_count > 0:
#         print(f'Task "{task}" removed from user with email {email}')
#     else:
#         print(f'No task "{task}" found for user with email {email}')