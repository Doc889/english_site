#!/bin/bash

# Start FastAPI Server for English Learning Platform

echo "🚀 Starting English Learning Platform API..."
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Please run: python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt"
    exit 1
fi

# Activate virtual environment and start server
source venv/bin/activate

echo "✅ Virtual environment activated"
echo "📡 Starting server on http://localhost:8000"
echo ""
echo "Available URLs:"
echo "  - Landing Page: http://localhost:8000"
echo "  - API Docs: http://localhost:8000/api/docs"
echo "  - Health Check: http://localhost:8000/health"
echo ""
echo "Press CTRL+C to stop the server"
echo ""

python main.py
