# Serverless Quick Start

1. Create the service locally
    ```bash
    serverless create \
      --template aws-python \
      --name <service_name> \
      --path <directory>
    ```

2. In a virtual environment, install required modules
    ```bash
    cd <directory>
    virtualenv venv
    source venv/bin/activate
    (venv) $ pip install requests
    ```

3. Export modules to requirements.txt
    ```
    (venv) $ pip freeze > requirements.txt
    ```

4. Add `serverless-python-requirements` plugin 
    ```
    (venv) $ npm init
    (venv) $ npm install --save serverless-python-requirements
    ```

5. Deploy
    ```
    serverless deploy
    ```

6. Invoke
    ```
    serverless invoke -f <function_name> --logs
    ```