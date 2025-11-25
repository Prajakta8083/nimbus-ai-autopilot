gcloud config set project quantum-conduit-479205-e4
gcloud projects list | awk '/PROJECT_ID/{print $2}'
gcloud services enable   run.googleapis.com   artifactregistry.googleapis.com   cloudbuild.googleapis.com   aiplatform.googleapis.com
gcloud config set run/region europe-west1
cd ~
git clone https://github.com/amitkmaraj/accelerate-ai-lab3-starter.git
cd accelerate-ai-lab3-starter
ls -R
cd ollama-backend/
ls
cloudshell edit Dockerfile
gcloud run deploy ollama-gemma3-270m-gpu   --source .   --region europe-west1   --concurrency 7   --cpu 8   --set-env-vars OLLAMA_NUM_PARALLEL=4   --gpu 1   --gpu-type nvidia-l4   --max-instances 1   --memory 16Gi   --allow-unauthenticated   --no-cpu-throttling   --no-gpu-zonal-redundancy   --timeout 600   --labels dev-tutorial=codelab-agent-gpu
export OLLAMA_URL=$(gcloud run services describe ollama-gemma3-270m-gpu \
    --region=europe-west1 \
    --format='value(status.url)')
echo "🎉 Gemma backend deployed at: $OLLAMA_URL"
cd ../adk-agent
ls
cloudshell edit production_agent/agent.py
cloudshell edit server.py
cloudshell edit Dockerfile
cat << EOF > .env
GOOGLE_CLOUD_PROJECT=$(gcloud config get-value project)
GOOGLE_CLOUD_LOCATION=europe-west1
GEMMA_MODEL_NAME=gemma3:270m
OLLAMA_API_BASE=$OLLAMA_URL
EOF

cat. env
cat .env
export PROJECT_ID=$(gcloud config get-value project)
gcloud run deploy production-adk-agent    --source .    --region europe-west1    --allow-unauthenticated    --memory 4Gi    --cpu 2    --max-instances 1    --concurrency 50    --timeout 300    --set-env-vars GOOGLE_CLOUD_PROJECT=$PROJECT_ID    --set-env-vars GOOGLE_CLOUD_LOCATION=europe-west1    --set-env-vars GEMMA_MODEL_NAME=gemma3:270m    --set-env-vars OLLAMA_API_BASE=$OLLAMA_URL    --labels dev-tutorial=codelab-agent-gpu
export AGENT_URL=$(gcloud run services describe production-adk-agent \
    --region=europe-west1 \
    --format='value(status.url)')
echo "🎉 ADK Agent deployed at: $AGENT_URL"
export AGENT_URL=$(gcloud run services describe production-adk-agent \
    --region=europe-west1 \
    --format='value(status.url)')
echo "🎉 ADK Agent deployed at: $AGENT_URL"
mkdir nimbus-backend
cd nimbus-backend
nano main.py
nano requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8080
pip install -r requirements.txt
cd ~/nimbus-backend
pip install sqlalchemy psycopg2-binary
pip install pg8000
nano requirements.txt
pip install -r requirements.txt
nano .env
nano main.py
DB_USER=postgres
DB_PASS=projects/PROJECT_ID/secrets/nimbus-db-password/versions/1
DB_NAME=nimbusdb
INSTANCE_CONNECTION_NAME=PROJECT_ID:asia-south1:nimbus-postgres
cd ~/nimbus-backend
nano database.py
nano main.py
uvicorn main:app --host 0.0.0.0 --port 8080
cd nimbus-backend
python3 main.py
uvicorn main:app --host 0.0.0.0 --port 8080
nano .env
ls
nano main.py
export DB_USER="postgres"
export DB_PASS="your-secret-password"
export DB_NAME="nimbusdb"
export DB_HOST="34.47.135.179"
uvicorn main:app --host 0.0.0.0 --port 8080
/test-db
uvicorn main:app --host 0.0.0.0 --port 8080
nano test_connection.py
cd ~/nimbus-backend
nano main.py
nano requirements.txt
pip install -r requirements.txt
nano .env
python3 - << 'EOF'
from dotenv import load_dotenv
import os
load_dotenv()
print("DB_HOST:", os.getenv("DB_HOST"))
print("DB_USER:", os.getenv("DB_USER"))
print("DB_NAME:", os.getenv("DB_NAME"))
EOF

ls -a
nano .env
python3 << 'EOF'
import os
from dotenv import load_dotenv

load_dotenv()

print("DB_HOST:", os.getenv("DB_HOST"))
print("DB_PASSWORD:", os.getenv("DB_PASSWORD"))
print("DB_USER:", os.getenv("DB_USER"))
print("DB_NAME:", os.getenv("DB_NAME"))
EOF

nano test_env.py
python3 test_env.py
nano .env
nano test_env.py
python3 test_env.py
nano .env
python3 test_env.py
nano test_env.py
python3 test_env.py
nano test_connection.py
python3 test_connection.py
curl ifconfig.me
python3 test_connection.py
nano .env
python3 test_connection.py
nano test_connection.py
python3 test_connection.py
nano database.py
nano main.py
python3 - << 'EOF'
from database import engine
from sqlalchemy import text

with engine.connect() as conn:
    conn.execute(text("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100)
        );
    """))
    conn.commit()

print("Users table created!")
EOF

uvicorn main:app --reload --host 0.0.0.0 --port 8080
python3 test_connection.py
uvicorn main:app --reload --host 0.0.0.0 --port 8080
nano main.py
uvicorn main:app --reload --host 0.0.0.0 --port 8080
nano requirements.txt
pip install google-genai
nano ai_service.py
nano main.py
nano .env
uvicorn main:app --reload --host 0.0.0.0 --port 8080
curl -X POST https://<your-cloudshell-url>/ai/summarize   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"  -H "Content-Type: application/json"  -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/api/summarize"     -H "Content-Type: application/json"     -d '{"text": "This is my sample text"}'
uvicorn main:app --reload --host 0.0.0.0 --port 8080
cat main.py
grep -R "@app" main.py
curl -X POST "https://8080-<your-cloudshell-url>/ai/summarize" -H "Content-Type: application/json" -d '{"text":"This is my sample text"}'
uvicorn main:app --reload --host 0.0.0.0 --port 8080
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"   -H "Content-Type: application/json"   -d '{"text":"This is my sample text"}'
echo $CLOUDSHELL_URL
ps -ef | grep uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8080
uvicorn main:app --reload --host 0.0.0.0 --port 8080
echo $CLOUDSHELL_URL
curl "$CLOUDSHELL_URL/"
grep -R "summarize" main.py
grep -R "extract" main.py
grep -R "plan" main.py
grep -R "summarize" main.py
grep -R "extract" main.py
grep -R "plan" main.py
nano main.py
nano ai_service.py
nano main.py
nano ai_service.py
nano main.py
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"      -H "Content-Type: application/json"      -d '{"text": "This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/extract-tasks"      -H "Content-Type: application/json"      -d '{"text": "Buy groceries tomorrow. Finish assignment today."}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/plan-day"      -H "Content-Type: application/json"      -d '{"tasks": ["Buy groceries", "Finish assignment", "Workout"]}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "Buy groceries tomorrow. Finish assignment today."}'
ps -ef | grep uvicorn
export CLOUDSHELL_URL="https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev"
echo $CLOUDSHELL_URL
curl -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
uvicorn main:app --reload --host 0.0.0.0 --port 8080
echo $CLOUDSHELL_URL
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize" -H "Content-Type: application/json" -d '{"text": "This is my sample text"}'
pkill -9 uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8080
curl https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/
pkill -9 uvicorn
ps -ef | grep uvicorn
cd ~/nimbus-backend
echo $CLOUDSHELL_URL
export CLOUDSHELL_URL=$(gp url 8080)
echo $CLOUDSHELL_URL
gp url 8080
export CLOUDSHELL_URL=https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev
echo $CLOUDSHELL_URL
curl -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text": "This is my sample text"}'
echo $CLOUDSHELL_URL
ps -ef | grep uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8080
cd ~/nimbus-backend
Web preview on port 8080: https://8080-xxxxxxx.cloudshell.dev
echo $CLOUDSHELL_URL
export CLOUDSHELL_URL=$(gp url 8080)
echo $CLOUDSHELL_URL
cd cd ~/nimbus-backend
cd ~/nimbus-backend
cloudshell open-url http://localhost:8080
export CLOUDSHELL_URL=$(cloudshell get-web-preview-url 8080)
echo $CLOUDSHELL_URL
cd ~/nimbus-backend
cloudshell get-web-preview-url --port=8080
export CLOUDSHELL_URL="https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev"
echo $CLOUDSHELL_URL
uvicorn main:app --reload --host 0.0.0.0 --port 8080
pkill -9 uvicorn
curl -X POST "$CLOUDSHELL_URL/ai/summarize" -H "Content-Type: application/json" -d '{"text":"This is my sample text"}'
uvicorn main:app --reload --host 0.0.0.0 --port 8080
curl -X POST "$CLOUDSHELL_URL/ai/summarize" -H "Content-Type: application/json" -d '{"text":"This is my sample text"}'
echo $CLOUDSHELL_URL
cd ~/nimbus-backend
uvicorn main:app --reload --host 0.0.0.0 --port 8080
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize"  -H "Content-Type: application/json"  -d '{"text":"This is my sample text"}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/extract-tasks"  -H "Content-Type: application/json"  -d '{"text":"Buy groceries tomorrow. Finish assignment today."}'
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/plan-day"  -H "Content-Type: application/json"  -d '{"tasks":["Buy groceries", "Finish assignment", "Workout"]}'
echo $CLOUDSHELL_URL
echo $CLOUDSHELL_URL
cd ~/nimbus-backend
uvicorn main:app --reload --host 0.0.0.0 --port 8080
pkill -9 uvicorn
cloudshell get-web-preview-url --port=8080
echo $CLOUDSHELL_URL
export CLOUDSHELL_URL=$(gp url 8080)
echo $CLOUDSHELL_URL
curl -v https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/
cd ~/nimbus-backend
curl -v https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize" \ 
curl -X POST "https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/ai/summarize" -H "Content-Type: application/json" -d '{"text":"This is my sample text"}'
ps -ef | grep uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8080
echo $CLOUDSHELL_URL
curl https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/
echo $CLOUDSHELL_URL
curl $CLOUDSHELL_URL/
export CLOUDSHELL_URL="https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev/"
echo $CLOUDSHELL_URL
curl $CLOUDSHELL_URL/
curl -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text":"This is my sample text"}'
curl -L -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text":"hello"}'
curl -v $CLOUDSHELL_URL/ai/summarize
echo $CLOUDSHELL_URL
export CLOUDSHELL_URL="https://8080-cs-341f54a2-5031-44ee-839f-f7d56c7e20f7.cs-asia-southeast1-yelo.cloudshell.dev"
echo $CLOUDSHELL_URL
curl -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text":"hello from nimbus"}'
cd ~/nimbus-backend
echo $CLOUDSHELL_URL
curl -X POST "$CLOUDSHELL_URL/ai/summarize"   -H "Content-Type: application/json"   -d '{"text":"hello from nimbus"}'
uvicorn main:app --reload --host 0.0.0.0 --port 8080
cd ~/nimbus-backend
nano Dockerfile
gcloud run deploy nimbus-backend     --source .     --region asia-south1     --allow-unauthenticated
curl https://nimbus-backend-803454342018.asia-south1.run.app/
curl https://nimbus-backend-803454342018.asia-south1.run.app/test-db
cloudshell edit main.py
nano requirements.txt
nano Dockerfile
gcloud run deploy nimbus-mini   --source .   --region asia-south1   --allow-unauthenticated
gcloud auth login
gcloud run deploy nimbus-backend   --source .   --region asia-south1   --allow-unauthenticated
curl https://nimbus-backend-803454342018.asia-south1.run.app/
curl https://nimbus-backend-803454342018.asia-south1.run.app/test-db
cloudshell edit .
