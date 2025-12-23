# English Learning Platform

A comprehensive English learning platform with 19 topics and 2,569+ quiz questions.

## Features

- 19 English learning topics (beginner level)
- 2,569+ interactive quiz questions
- Static HTML pages with embedded content
- FastAPI backend for serving content and API endpoints
- No database required - all content is embedded in HTML files

## Quick Start

### Option 1: Run with FastAPI Backend

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the server:
```bash
python run.py
```

3. Open in browser:
- Main site: http://localhost:8000
- API docs: http://localhost:8000/api/docs
- Health check: http://localhost:8000/api/health

### Option 2: Serve Static Files Only

```bash
cd static_site
python3 -m http.server 8080
```

Open: http://localhost:8080

## API Endpoints

- `GET /api/health` - Health check
- `GET /api/info` - Application information
- `GET /api/topics` - Get all topics
- `GET /api/topics?difficulty=beginner` - Filter topics by difficulty
- `GET /api/topics/{topic_id}` - Get specific topic
- `GET /api/stats` - Platform statistics

## Project Structure

```
.
├── app/
│   ├── main.py              # FastAPI application
│   ├── config.py            # Configuration
│   └── api/
│       └── routes/
│           ├── health.py    # Health check routes
│           └── topics.py    # Topics API routes
├── static_site/
│   ├── index.html           # Landing page
│   └── topics/              # 19 topic HTML files
├── requirements.txt         # Python dependencies
├── run.py                   # Server startup script
└── README.md               # This file
```

## Topics Included

1. Alphabet & Pronunciation
2. Greetings & Introductions
3. Articles (a, an, the)
4. Pronouns
5. Adjectives
6. Verb "to be"
7. Present Simple
8. Modal Verbs
9. There is/are
10. Prepositions of Place
11. Question Words
12. Numbers, Dates, Time
13. Present Continuous
14. Future Simple
15. Be Going To
16. Past Simple
17. Past Continuous
18. Present Perfect
19. Comparatives & Superlatives

## Deployment

### Deploy Static Site Only
Upload the `static_site/` directory to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service

### Deploy with Backend
Deploy the entire project to:
- Heroku
- Railway
- Render
- Any platform supporting Python/FastAPI

## License

Free to use for educational purposes.
