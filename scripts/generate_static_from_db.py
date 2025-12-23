#!/usr/bin/env python3
"""
Generate fully static HTML site from database
NO DATABASE NEEDED after generation - all data embedded in HTML
"""

import json
import sys
from pathlib import Path

# Add parent directory to path to import app modules
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.db.models import Topic, RuleSection, RuleExample, Question, QuestionOption

# Database connection
DATABASE_URL = "postgresql://doc@localhost/english_learning"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)


def get_all_topics():
    """Fetch all topics from database"""
    db = SessionLocal()
    try:
        topics = db.query(Topic).order_by(Topic.display_order).all()
        return topics
    finally:
        db.close()


def get_topic_content(topic_id):
    """Fetch complete topic content including rules, examples, and questions"""
    db = SessionLocal()
    try:
        # Get topic
        topic = db.query(Topic).filter(Topic.id == topic_id).first()
        if not topic:
            return None

        # Get rules with examples
        rules = db.query(RuleSection).filter(
            RuleSection.topic_id == topic_id
        ).order_by(RuleSection.display_order).all()

        rules_data = []
        for rule in rules:
            examples = db.query(RuleExample).filter(
                RuleExample.rule_section_id == rule.id
            ).order_by(RuleExample.display_order).all()

            rules_data.append({
                'title': rule.title,
                'content': rule.content,
                'examples': [ex.example_text for ex in examples]
            })

        # Get questions with options
        questions = db.query(Question).filter(
            Question.topic_id == topic_id
        ).order_by(Question.display_order).all()

        questions_data = []
        for question in questions:
            options = db.query(QuestionOption).filter(
                QuestionOption.question_id == question.id
            ).order_by(QuestionOption.option_index).all()

            questions_data.append({
                'text': question.question_text,
                'options': [opt.option_text for opt in options],
                'correct_index': question.correct_index,
                'explanation': question.explanation
            })

        return {
            'topic': {
                'id': topic.id,
                'title': topic.title,
                'description': topic.description,
                'total_questions': len(questions_data)
            },
            'rules': rules_data,
            'questions': questions_data
        }
    finally:
        db.close()


def split_questions_into_quizzes(questions, questions_per_quiz=20):
    """Split questions into quiz sets"""
    quizzes = {}
    for i in range(0, len(questions), questions_per_quiz):
        quiz_num = (i // questions_per_quiz) + 1
        quizzes[quiz_num] = questions[i:i + questions_per_quiz]
    return quizzes


def generate_static_html(topic_content):
    """Generate static HTML for a topic"""
    topic = topic_content['topic']
    rules = topic_content['rules']
    questions = topic_content['questions']

    # Split questions into quizzes
    if len(questions) >= 200:
        quizzes = split_questions_into_quizzes(questions, 20)
    elif len(questions) > 0:
        quizzes = {1: questions}
    else:
        quizzes = {}

    # Generate theory HTML
    theory_html = ''
    for rule in rules:
        theory_html += f'''
        <div class="rule-section">
            <h3 class="rule-title">{rule['title']}</h3>
            <p class="rule-content">{rule['content']}</p>
'''
        if rule['examples']:
            theory_html += '            <div class="examples">\n'
            for example in rule['examples']:
                theory_html += f'                <div class="example">{example}</div>\n'
            theory_html += '            </div>\n'
        theory_html += '        </div>\n'

    # Generate quiz selector buttons
    quiz_selector_html = ''
    if len(quizzes) > 1:
        for quiz_num in sorted(quizzes.keys()):
            quiz_selector_html += f'                <button type="button" class="quiz-selector-btn" data-quiz="{quiz_num}" onclick="loadQuiz({quiz_num})">Тест {quiz_num}</button>\n'

    # Generate quiz data JSON
    quiz_data_json = {}
    for quiz_num, quiz_questions in quizzes.items():
        quiz_data_json[quiz_num] = []
        for q in quiz_questions:
            quiz_data_json[quiz_num].append({
                'text': q['text'],
                'options': q['options'],
                'correct_index': q['correct_index'],
                'explanation': q['explanation']
            })

    # Display settings
    has_multiple_quizzes = len(quizzes) > 1
    placeholder_display = 'display: block;' if has_multiple_quizzes else 'display: none;'
    form_display = 'display: none;' if has_multiple_quizzes else 'display: block;'

    # Generate complete HTML
    html = f'''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{topic['title']} - Английский язык</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {{
            --color-primary: #7c3aed;
            --color-primary-dark: #6d28d9;
            --color-primary-light: #a78bfa;
            --color-secondary: #c4b5fd;
            --color-accent: #ddd6fe;
            --color-bg: #ffffff;
            --color-bg-alt: #faf5ff;
            --color-text: #1f2937;
            --color-text-light: #6b7280;
            --color-white: #ffffff;
            --color-success: #10b981;
            --color-error: #ef4444;
            --font-display: 'Playfair Display', serif;
            --font-body: 'DM Sans', sans-serif;
            --shadow-sm: 0 2px 8px rgba(124, 58, 237, 0.08);
            --shadow-md: 0 4px 20px rgba(124, 58, 237, 0.12);
            --shadow-lg: 0 8px 40px rgba(124, 58, 237, 0.16);
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }}

        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: var(--font-body);
            background-color: var(--color-bg);
            color: var(--color-text);
            line-height: 1.7;
        }}

        header {{
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
            color: var(--color-white);
            padding: 3rem 2rem;
            text-align: center;
        }}

        .back-link {{
            display: inline-block;
            color: var(--color-accent);
            text-decoration: none;
            margin-bottom: 1rem;
            transition: var(--transition);
        }}

        .back-link:hover {{
            color: var(--color-white);
        }}

        h1 {{
            font-family: var(--font-display);
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }}

        .description {{
            font-size: 1.2rem;
            opacity: 0.9;
        }}

        main {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }}

        .section-title {{
            font-family: var(--font-display);
            font-size: 2.5rem;
            color: var(--color-primary);
            margin-bottom: 2rem;
            text-align: center;
        }}

        .rule-section {{
            background: var(--color-white);
            border-left: 4px solid var(--color-primary);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 8px;
            box-shadow: var(--shadow-sm);
        }}

        .rule-title {{
            font-family: var(--font-display);
            font-size: 1.8rem;
            color: var(--color-primary);
            margin-bottom: 1rem;
        }}

        .rule-content {{
            color: var(--color-text);
            margin-bottom: 1rem;
            line-height: 1.8;
            white-space: pre-wrap;
        }}

        .examples {{
            background: var(--color-bg-alt);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
        }}

        .example {{
            padding: 0.5rem;
            margin: 0.25rem 0;
            font-family: monospace;
            font-size: 0.95rem;
        }}

        .quiz-section {{
            background: var(--color-bg-alt);
            padding: 3rem 2rem;
            margin-top: 3rem;
            border-radius: 12px;
        }}

        #quiz-selector {{
            margin-bottom: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.8rem;
        }}

        .quiz-selector-btn {{
            padding: 1rem 2rem;
            background: var(--color-bg);
            border: 2px solid var(--color-primary);
            color: var(--color-primary);
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            min-width: 250px;
        }}

        .quiz-selector-btn:hover {{
            background: var(--color-primary);
            color: white;
            transform: translateY(-2px);
        }}

        .quiz-selector-btn.active {{
            background: var(--color-primary);
            color: white;
        }}

        #quiz-placeholder {{
            text-align: center;
            padding: 3rem;
            color: var(--color-text-light);
        }}

        #quiz-form {{
            max-width: 800px;
            margin: 0 auto;
        }}

        .question {{
            background: var(--color-white);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
        }}

        .question-text {{
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--color-text);
        }}

        .options {{
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }}

        .option {{
            display: flex;
            align-items: center;
            padding: 1rem;
            background: var(--color-bg);
            border: 2px solid var(--color-accent);
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
        }}

        .option:hover {{
            border-color: var(--color-primary);
            background: var(--color-bg-alt);
        }}

        .option input[type="radio"] {{
            margin-right: 1rem;
            cursor: pointer;
        }}

        .submit-btn {{
            width: 100%;
            padding: 1.2rem 2rem;
            background: var(--color-primary);
            color: var(--color-white);
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 2rem;
        }}

        .submit-btn:hover {{
            background: var(--color-primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }}

        .submit-btn:disabled {{
            background: var(--color-text-light);
            cursor: not-allowed;
            transform: none;
        }}

        #results {{
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--color-white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            text-align: center;
        }}

        #results.hidden {{
            display: none;
        }}

        .score {{
            font-family: var(--font-display);
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }}

        .score.pass {{
            color: var(--color-success);
        }}

        .score.fail {{
            color: var(--color-error);
        }}

        .feedback {{
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }}

        .retry-btn {{
            padding: 1rem 2rem;
            background: var(--color-primary);
            color: var(--color-white);
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 1rem;
        }}

        .retry-btn:hover {{
            background: var(--color-primary-dark);
        }}

        .home-btn {{
            display: inline-block;
            margin-top: 1rem;
            padding: 0.75rem 1.5rem;
            background: var(--color-white);
            color: var(--color-primary);
            border: 2px solid var(--color-primary);
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }}

        .home-btn:hover {{
            background: var(--color-primary);
            color: var(--color-white);
        }}

        @media (max-width: 768px) {{
            h1 {{
                font-size: 2rem;
            }}
            .section-title {{
                font-size: 2rem;
            }}
        }}
    </style>
</head>
<body>
    <header>
        <div class="container">
            <a href="../index.html" class="back-link">← Назад ко всем темам</a>
            <h1>{topic['title']}</h1>
            <p class="description">{topic['description']}</p>
        </div>
    </header>

    <main>
        <h2 class="section-title">📚 Теория</h2>

        {theory_html}

        <div class="quiz-section">
            <h2 class="section-title">✏️ Проверь себя</h2>
            <p style="text-align: center; margin-bottom: 2rem; font-size: 1.1rem;">
                Всего вопросов: {topic['total_questions']}
            </p>

            <div id="quiz-selector">
{quiz_selector_html}            </div>

            <div id="quiz-placeholder" style="{placeholder_display}">
                <p style="font-size: 1.2rem;">Выберите тест, чтобы начать</p>
            </div>

            <form id="quiz-form" style="{form_display}">
                <button type="submit" class="submit-btn" id="submit-btn">Проверить ответы</button>
            </form>

            <div id="results" class="hidden">
                <div class="score" id="score"></div>
                <div class="feedback" id="feedback"></div>
                <p id="details"></p>
                <button class="retry-btn" onclick="retryQuiz()">Попробовать ещё раз</button>
                <br>
                <a href="../index.html" class="home-btn">На главную</a>
            </div>
        </div>
    </main>

    <script>
        const allQuizData = {json.dumps(quiz_data_json, ensure_ascii=False)};
        let currentQuizSet = 1;

        function loadQuiz(quizSet) {{
            currentQuizSet = quizSet;

            const placeholder = document.getElementById('quiz-placeholder');
            const form = document.getElementById('quiz-form');
            if (placeholder) {{
                placeholder.style.display = 'none';
            }}
            if (form.style.display === 'none') {{
                form.style.display = 'block';
            }}

            document.querySelectorAll('.quiz-selector-btn').forEach(btn => {{
                btn.classList.remove('active');
                if (parseInt(btn.dataset.quiz) === quizSet) {{
                    btn.classList.add('active');
                }}
            }});

            const questions = allQuizData[quizSet] || [];
            const submitBtn = document.getElementById('submit-btn');
            const existingQuestions = form.querySelectorAll('.question');
            existingQuestions.forEach(q => q.remove());

            questions.forEach((question, index) => {{
                const questionDiv = document.createElement('div');
                questionDiv.className = 'question';

                let optionsHtml = '';
                question.options.forEach((option, optIndex) => {{
                    optionsHtml += `
                        <label class="option">
                            <input type="radio" name="question-${{index}}" value="${{optIndex}}" required>
                            <span>${{option}}</span>
                        </label>
                    `;
                }});

                questionDiv.innerHTML = `
                    <div class="question-text">${{index + 1}}. ${{question.text}}</div>
                    <div class="options">
                        ${{optionsHtml}}
                    </div>
                `;

                form.insertBefore(questionDiv, submitBtn);
            }});

            form.reset();
            submitBtn.disabled = false;
            document.getElementById('results').classList.add('hidden');
        }}

        const quizSetCount = Object.keys(allQuizData).length;
        if (quizSetCount === 1) {{
            loadQuiz(1);
        }}

        document.getElementById('quiz-form').addEventListener('submit', function(e) {{
            e.preventDefault();

            const questions = allQuizData[currentQuizSet];
            let correct = 0;

            questions.forEach((question, index) => {{
                const selected = document.querySelector(`input[name="question-${{index}}"]:checked`);
                if (selected && parseInt(selected.value) === question.correct_index) {{
                    correct++;
                }}
            }});

            const total = questions.length;
            const percentage = Math.round((correct / total) * 100);

            document.getElementById('score').textContent = percentage + '%';
            document.getElementById('score').className = percentage >= 70 ? 'score pass' : 'score fail';

            let feedback;
            if (percentage >= 90) {{
                feedback = 'Отлично!';
            }} else if (percentage >= 70) {{
                feedback = 'Хорошо!';
            }} else if (percentage >= 50) {{
                feedback = 'Неплохо, но можно лучше';
            }} else {{
                feedback = 'Нужно ещё поучить';
            }}

            document.getElementById('feedback').textContent = feedback;
            document.getElementById('details').textContent = `Правильных ответов: ${{correct}} из ${{total}}`;

            document.getElementById('results').classList.remove('hidden');
            document.getElementById('results').scrollIntoView({{ behavior: 'smooth' }});

            this.querySelector('.submit-btn').disabled = true;
        }});

        function retryQuiz() {{
            document.getElementById('results').classList.add('hidden');
            document.getElementById('quiz-form').reset();
            document.querySelector('.submit-btn').disabled = false;
            document.getElementById('quiz-form').scrollIntoView({{ behavior: 'smooth' }});
        }}
    </script>
</body>
</html>'''

    return html


def generate_index_page(topics):
    """Generate index.html with all topics"""
    topics_json = []
    for topic in topics:
        topics_json.append({
            'id': topic.id,
            'title': topic.title,
            'description': topic.description,
            'total_questions': topic.total_questions
        })

    html = f'''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Английский язык - Бесплатное обучение</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {{
            --color-primary: #7c3aed;
            --color-primary-dark: #6d28d9;
            --color-primary-light: #a78bfa;
            --color-secondary: #c4b5fd;
            --color-accent: #ddd6fe;
            --color-bg: #ffffff;
            --color-bg-alt: #faf5ff;
            --color-text: #1f2937;
            --color-text-light: #6b7280;
            --color-white: #ffffff;
            --font-display: 'Playfair Display', serif;
            --font-body: 'DM Sans', sans-serif;
            --shadow-sm: 0 2px 8px rgba(124, 58, 237, 0.08);
            --shadow-md: 0 4px 20px rgba(124, 58, 237, 0.12);
            --shadow-lg: 0 8px 40px rgba(124, 58, 237, 0.16);
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }}

        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        html {{
            scroll-behavior: smooth;
        }}

        body {{
            font-family: var(--font-body);
            background-color: var(--color-bg);
            color: var(--color-text);
            line-height: 1.7;
            overflow-x: hidden;
        }}

        header {{
            top: 0;
            z-index: 100;
            background: rgba(250, 247, 244, 0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(212, 102, 79, 0.1);
            padding: 3rem 2rem;
            text-align: center;
        }}

        .main-title {{
            font-family: var(--font-display);
            font-size: 3.5rem;
            font-weight: 800;
            color: var(--color-primary);
            margin-bottom: 1rem;
            letter-spacing: -1px;
        }}

        .subtitle {{
            font-size: 1.2rem;
            color: var(--color-text-light);
            margin-bottom: 0.5rem;
        }}

        .free-badge {{
            display: inline-block;
            padding: 0.5rem 1.5rem;
            background: var(--color-accent);
            color: var(--color-primary);
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-top: 1rem;
        }}

        main {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }}

        .level-section {{
            margin-bottom: 4rem;
        }}

        .level-header {{
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid var(--color-primary);
        }}

        .level-badge {{
            padding: 0.5rem 1.5rem;
            background: var(--color-primary);
            color: var(--color-white);
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }}

        .level-title {{
            font-family: var(--font-display);
            font-size: 2.5rem;
            color: var(--color-text);
            font-weight: 700;
        }}

        .topics-list {{
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }}

        .topic-item {{
            background: var(--color-white);
            border: 2px solid var(--color-accent);
            padding: 1.5rem;
            border-radius: 16px;
            transition: var(--transition);
            cursor: pointer;
            text-decoration: none;
            color: var(--color-text);
            display: block;
        }}

        .topic-item:hover {{
            border-color: var(--color-primary);
            background: var(--color-bg-alt);
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
        }}

        .topic-item h3 {{
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--color-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }}

        .topic-item h3::before {{
            content: '•';
            font-size: 1.5rem;
        }}

        .topic-item p {{
            font-size: 0.9rem;
            color: var(--color-text-light);
            line-height: 1.5;
        }}

        footer {{
            background: var(--color-primary);
            color: var(--color-white);
            padding: 3rem 2rem;
            text-align: center;
        }}

        .footer-content {{
            max-width: 1200px;
            margin: 0 auto;
        }}

        .footer-content p {{
            margin-bottom: 1rem;
            opacity: 0.9;
        }}

        @media (max-width: 768px) {{
            .main-title {{
                font-size: 2.5rem;
            }}

            .subtitle {{
                font-size: 1.1rem;
            }}

            .level-title {{
                font-size: 2rem;
            }}

            .topics-list {{
                grid-template-columns: 1fr;
            }}
        }}
    </style>
</head>
<body>
    <header>
        <h1 class="main-title">Победи грамматику английского языка</h1>
        <p class="subtitle">Перед тобой инструмент, с помощью которого ты поймёшь суть английского языка и навсегда закроешь свои пробелы в грамматике. Тебя ждут сотни тестов. Все зависит только от тебя.</p>
        <span class="free-badge">100% Free Learning</span>
    </header>

    <main>
        <section class="level-section">
            <div class="level-header">
                <span class="level-badge">Beginner</span>
                <h2 class="level-title">Foundation Topics</h2>
            </div>
            <div id="topics-container" class="topics-list">
                <!-- Topics will be inserted here -->
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <p>Бесплатная платформа для изучения английского языка</p>
            <p>Все материалы доступны без регистрации</p>
        </div>
    </footer>

    <script>
        const topics = {json.dumps(topics_json, ensure_ascii=False)};

        const container = document.getElementById('topics-container');

        // Filter to show only topics up to present_continuous
        const allowedTopics = topics.filter(topic => {{
            const topicOrder = [
                'alphabet-pronunciation',
                'greetings-introductions',
                'articles',
                'pronouns',
                'adjectives',
                'to_be',
                'present_simple',
                'modal_verbs',
                'there_is_are',
                'prepositions_place',
                'question_words',
                'numbers_dates_time',
                'present_continuous'
            ];
            return topicOrder.includes(topic.id);
        }});

        allowedTopics.forEach(topic => {{
            const card = document.createElement('a');
            card.href = `topics/${{topic.id}}.html`;
            card.className = 'topic-item';

            card.innerHTML = `
                <h3>${{topic.title}}</h3>
                <p>${{topic.description}}</p>
            `;

            container.appendChild(card);
        }});
    </script>
</body>
</html>'''

    return html


def main():
    """Generate static site from database"""
    print("=" * 70)
    print("Generating Static HTML Site from Database")
    print("=" * 70)

    output_dir = Path(__file__).parent.parent / 'static_site'
    topics_dir = output_dir / 'topics'

    # Create directories
    output_dir.mkdir(exist_ok=True)
    topics_dir.mkdir(exist_ok=True)

    # Get all topics
    topics = get_all_topics()
    print(f"\nFound {len(topics)} topics in database\n")

    # Generate topic pages
    for topic in topics:
        print(f"Generating {topic.id}.html...")

        content = get_topic_content(topic.id)
        if not content:
            print(f"  ⚠️  No content found")
            continue

        html = generate_static_html(content)

        output_file = topics_dir / f"{topic.id}.html"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(html)

        print(f"  ✓ {len(content['rules'])} rules, {len(content['questions'])} questions")

    # Generate index page
    print("\nGenerating index.html...")
    index_html = generate_index_page(topics)
    with open(output_dir / 'index.html', 'w', encoding='utf-8') as f:
        f.write(index_html)
    print("  ✓ Index page generated")

    print(f"\n{'=' * 70}")
    print("✅ Static site generated successfully!")
    print(f"{'=' * 70}")
    print(f"\nLocation: {output_dir}")
    print(f"\nTo view:")
    print(f"  1. cd {output_dir}")
    print(f"  2. python3 -m http.server 8080")
    print(f"  3. Open http://localhost:8080")
    print(f"\n💡 No database required - all content embedded in HTML files!")


if __name__ == "__main__":
    main()
