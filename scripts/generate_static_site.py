#!/usr/bin/env python3
"""
Generate static HTML site from database content
"""

import sys
import json
from pathlib import Path

# Add parent directory to path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy.orm import Session
from app.db.base import SessionLocal
from app.db.models import Topic, RuleSection, RuleExample, Question, QuestionOption


def get_topic_html_template():
    """Return HTML template for topic pages"""
    return '''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title} - Английский язык</title>
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
            --color-success: #10b981;
            --color-error: #ef4444;
            --font-display: 'Playfair Display', serif;
            --font-body: 'DM Sans', sans-serif;
            --shadow-sm: 0 2px 8px rgba(124, 58, 237, 0.08);
            --shadow-md: 0 4px 20px rgba(124, 58, 237, 0.12);
            --transition: all 0.3s ease;
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

        .container {{
            max-width: 900px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }}

        header {{
            background: var(--color-primary);
            color: white;
            padding: 2rem;
            text-align: center;
        }}

        .back-link {{
            display: inline-block;
            color: white;
            text-decoration: none;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            opacity: 0.9;
            transition: var(--transition);
        }}

        .back-link:hover {{
            opacity: 1;
            transform: translateX(-3px);
        }}

        header h1 {{
            font-family: var(--font-display);
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }}

        header p {{
            font-size: 1.2rem;
            opacity: 0.95;
        }}

        .content-section {{
            margin-bottom: 3rem;
        }}

        .section-title {{
            font-family: var(--font-display);
            font-size: 2.5rem;
            color: var(--color-primary);
            margin: 3rem 0 2rem;
            text-align: center;
        }}

        .rule-section {{
            background: var(--color-bg-alt);
            border-left: 4px solid var(--color-primary);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
        }}

        .rule-title {{
            font-family: var(--font-display);
            font-size: 1.8rem;
            color: var(--color-primary);
            margin-bottom: 1rem;
        }}

        .rule-content {{
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            line-height: 1.8;
            white-space: pre-line;
        }}

        .examples {{
            margin-top: 1.5rem;
        }}

        .example {{
            background: var(--color-bg);
            padding: 0.8rem 1.2rem;
            margin-bottom: 0.5rem;
            border-radius: 8px;
            border-left: 3px solid var(--color-secondary);
            font-family: monospace;
            font-size: 1rem;
        }}

        .quiz-section {{
            background: var(--color-bg-alt);
            padding: 3rem;
            border-radius: 16px;
            margin-top: 3rem;
        }}

        .question {{
            background: var(--color-bg);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            border: 2px solid transparent;
            transition: var(--transition);
        }}

        .question.correct {{
            border-color: var(--color-success);
            background: #f0fdf4;
        }}

        .question.incorrect {{
            border-color: var(--color-error);
            background: #fef2f2;
        }}

        .question-text {{
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: var(--color-text);
        }}

        .options {{
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }}

        .option {{
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            background: var(--color-bg-alt);
            border: 2px solid var(--color-accent);
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
        }}

        .option:hover {{
            border-color: var(--color-primary);
            background: white;
        }}

        .option input[type="radio"] {{
            margin-right: 1rem;
            cursor: pointer;
        }}

        .option.correct {{
            background: #dcfce7;
            border-color: var(--color-success);
        }}

        .option.incorrect {{
            background: #fee2e2;
            border-color: var(--color-error);
        }}

        .submit-btn {{
            display: block;
            width: 100%;
            padding: 1.2rem;
            background: var(--color-primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 2rem;
            transition: var(--transition);
        }}

        .submit-btn:hover:not(:disabled) {{
            background: var(--color-primary-dark);
            transform: translateY(-2px);
        }}

        .submit-btn:disabled {{
            background: var(--color-text-light);
            cursor: not-allowed;
            transform: none;
        }}

        .results {{
            text-align: center;
            padding: 2rem;
            background: var(--color-primary);
            color: white;
            border-radius: 12px;
            margin-top: 2rem;
        }}

        .results.hidden {{
            display: none;
        }}

        .score {{
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }}

        .score.pass {{
            color: #dcfce7;
        }}

        .score.fail {{
            color: #fecaca;
        }}

        .results-message {{
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }}

        .retry-btn {{
            padding: 0.8rem 1.5rem;
            background: var(--color-bg);
            border: 2px solid white;
            color: var(--color-primary);
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-right: 1rem;
        }}

        .retry-btn:hover {{
            background: white;
            transform: translateY(-2px);
        }}

        .home-btn {{
            background: transparent;
            color: white;
            border: 2px solid white;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: var(--transition);
        }}

        .home-btn:hover {{
            background: white;
            color: var(--color-primary);
            transform: translateY(-2px);
        }}

        .quiz-selector-btn {{
            padding: 0.8rem 1.5rem;
            background: var(--color-bg);
            border: 2px solid var(--color-primary);
            color: var(--color-primary);
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            min-width: 200px;
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

        @media (max-width: 768px) {{
            header h1 {{
                font-size: 2rem;
            }}

            .section-title {{
                font-size: 2rem;
            }}

            .container {{
                padding: 2rem 1rem;
            }}
        }}
    </style>
</head>
<body>
    <header>
        <div class="container">
            <a href="../index.html" class="back-link">← Назад ко всем темам</a>
            <h1>{title}</h1>
            <p>{description}</p>
        </div>
    </header>

    <div class="container">
        <!-- Theory Section -->
        <div class="content-section">
            <h2 class="section-title">Теория</h2>
            {theory_html}
        </div>

        <!-- Results Section (hidden initially) -->
        <div id="results" class="results hidden">
            <div class="score" id="score"></div>
            <div class="results-message" id="results-message"></div>
            <div>
                <button class="retry-btn" onclick="retakeQuiz()">Пройти ещё раз</button>
                <a href="../index.html" class="home-btn">На главную</a>
            </div>
        </div>

        <!-- Quiz Section -->
        <div class="quiz-section" id="quiz-section">
            <h2 class="section-title">Тест</h2>

            <!-- Quiz Selector (shown if multiple quizzes) -->
            <div id="quiz-selector" style="margin-bottom: 2rem; display: flex; flex-direction: column; align-items: center; gap: 0.8rem;">
                {quiz_selector_html}
            </div>

            <div id="quiz-placeholder" style="text-align: center; padding: 3rem; color: var(--color-text-light); {placeholder_display}">
                <p style="font-size: 1.2rem;">Выберите тест, чтобы начать</p>
            </div>

            <form id="quiz-form" style="{form_display}">
                {quiz_html}
                <button type="submit" class="submit-btn" id="submit-btn">Проверить ответы</button>
            </form>
        </div>
    </div>

    <script>
        const allQuizData = {all_quiz_data_json};
        let currentQuizSet = 1;
        const quizData = allQuizData[currentQuizSet] || [];

        function checkAnswers(event) {{
            event.preventDefault();

            const form = document.getElementById('quiz-form');
            const formData = new FormData(form);

            let correct = 0;
            let total = quizData.length;

            // Check each question
            quizData.forEach((question, index) => {{
                const selectedAnswer = parseInt(formData.get(`question-${{question.id}}`));
                const options = document.querySelectorAll(`input[name="question-${{question.id}}"]`);

                options.forEach((option, optIndex) => {{
                    const label = option.closest('.option');
                    if (optIndex === question.correct_index) {{
                        label.classList.add('correct');
                    }}
                    if (selectedAnswer === optIndex && selectedAnswer !== question.correct_index) {{
                        label.classList.add('incorrect');
                    }}
                    option.disabled = true;
                }});

                if (selectedAnswer === question.correct_index) {{
                    correct++;
                }}
            }});

            // Calculate score
            const percentage = Math.round((correct / total) * 100);
            const passed = percentage >= 70;

            // Show results
            const resultsDiv = document.getElementById('results');
            const scoreDiv = document.getElementById('score');
            const messageDiv = document.getElementById('results-message');

            scoreDiv.textContent = `${{percentage}}%`;
            scoreDiv.className = 'score ' + (passed ? 'pass' : 'fail');

            messageDiv.textContent = `Вы ответили правильно на ${{correct}} из ${{total}} вопросов`;

            resultsDiv.classList.remove('hidden');

            // Disable submit button
            document.getElementById('submit-btn').disabled = true;

            // Scroll to results
            resultsDiv.scrollIntoView({{ behavior: 'smooth', block: 'center' }});
        }}

        function retakeQuiz() {{
            loadQuiz(currentQuizSet);
        }}

        function loadQuiz(quizSet) {{
            currentQuizSet = quizSet;

            // Hide placeholder, show form (if they exist)
            const placeholder = document.getElementById('quiz-placeholder');
            const form = document.getElementById('quiz-form');
            if (placeholder) {{
                placeholder.style.display = 'none';
            }}
            if (form.style.display === 'none') {{
                form.style.display = 'block';
            }}

            // Update button states
            document.querySelectorAll('.quiz-selector-btn').forEach(btn => {{
                btn.classList.remove('active');
                if (parseInt(btn.dataset.quiz) === quizSet) {{
                    btn.classList.add('active');
                }}
            }});

            // Get questions for this quiz set
            const questions = allQuizData[quizSet] || [];

            // Clear and rebuild quiz HTML
            const submitBtn = document.getElementById('submit-btn');

            // Remove all questions
            const existingQuestions = form.querySelectorAll('.question');
            existingQuestions.forEach(q => q.remove());

            // Add new questions
            questions.forEach((question, index) => {{
                const questionDiv = document.createElement('div');
                questionDiv.className = 'question';
                questionDiv.dataset.questionId = question.id;

                let optionsHtml = '';
                question.options.forEach((option, optIndex) => {{
                    optionsHtml += `
                        <label class="option">
                            <input type="radio" name="question-${{question.id}}" value="${{optIndex}}" required>
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

            // Reset form state
            form.reset();
            submitBtn.disabled = false;
            document.getElementById('results').classList.add('hidden');
            document.querySelectorAll('.option').forEach(opt => {{
                opt.classList.remove('correct', 'incorrect');
            }});

            // Scroll to quiz
            form.scrollIntoView({{ behavior: 'smooth', block: 'start' }});
        }}

        // Initialize: if only one quiz set, load it automatically
        const quizSetCount = Object.keys(allQuizData).length;
        if (quizSetCount === 1) {{
            // Single quiz - load immediately
            loadQuiz(1);
        }}
        // If multiple quiz sets, user must select one (placeholder will show)

        document.getElementById('quiz-form').addEventListener('submit', checkAnswers);
    </script>
</body>
</html>
'''


def generate_theory_html(sections):
    """Generate HTML for theory sections"""
    html_parts = []

    for section in sections:
        examples_html = ''
        if section.examples:
            examples_html = '<div class="examples">'
            for example in sorted(section.examples, key=lambda e: e.display_order):
                examples_html += f'<div class="example">{example.example_text}</div>'
            examples_html += '</div>'

        html_parts.append(f'''
        <div class="rule-section">
            <h3 class="rule-title">{section.title}</h3>
            <div class="rule-content">{section.content}</div>
            {examples_html}
        </div>
        ''')

    return '\n'.join(html_parts)


def generate_quiz_html(questions):
    """Generate HTML for quiz questions"""
    html_parts = []

    for idx, question in enumerate(questions, 1):
        options_html = ''
        for opt in sorted(question.options, key=lambda o: o.option_index):
            options_html += f'''
            <label class="option">
                <input type="radio" name="question-{question.id}" value="{opt.option_index}" required>
                <span>{opt.option_text}</span>
            </label>
            '''

        html_parts.append(f'''
        <div class="question">
            <div class="question-text">{idx}. {question.question_text}</div>
            <div class="options">
                {options_html}
            </div>
        </div>
        ''')

    return '\n'.join(html_parts)


def generate_quiz_selector_html(questions):
    """Generate HTML for quiz selector buttons"""
    # Group questions by quiz_set
    quiz_sets = {}
    for q in questions:
        quiz_set = q.quiz_set if q.quiz_set else 1
        if quiz_set not in quiz_sets:
            quiz_sets[quiz_set] = []
        quiz_sets[quiz_set].append(q)

    # If only one quiz set, don't show selector
    if len(quiz_sets) <= 1:
        return ''

    # Generate buttons
    buttons = []
    for quiz_num in sorted(quiz_sets.keys()):
        buttons.append(
            f'<button type="button" class="quiz-selector-btn" data-quiz="{quiz_num}" '
            f'onclick="loadQuiz({quiz_num})">Тест {quiz_num}</button>'
        )

    return '\n'.join(buttons)


def generate_all_quiz_data_json(questions):
    """Generate JSON data organized by quiz sets"""
    # Group questions by quiz_set
    quiz_sets = {}
    for question in questions:
        quiz_set = question.quiz_set if question.quiz_set else 1
        if quiz_set not in quiz_sets:
            quiz_sets[quiz_set] = []

        # Sort options by option_index
        sorted_options = sorted(question.options, key=lambda o: o.option_index)

        quiz_sets[quiz_set].append({
            'id': question.id,
            'text': question.question_text,
            'options': [opt.option_text for opt in sorted_options],
            'correct_index': question.correct_index
        })

    return json.dumps(quiz_sets, ensure_ascii=False)


def generate_static_site(db: Session):
    """Generate complete static HTML site"""

    output_dir = Path(__file__).parent.parent / 'static_site'
    topics_dir = output_dir / 'topics'

    # Get all topics
    topics = db.query(Topic).order_by(Topic.display_order).all()

    print(f"Found {len(topics)} topics to generate")

    # Generate topic pages
    for topic in topics:
        print(f"\nGenerating {topic.id}.html...")

        # Get theory sections
        sections = db.query(RuleSection).filter(
            RuleSection.topic_id == topic.id
        ).order_by(RuleSection.display_order).all()

        print(f"  Theory sections: {len(sections)}")

        # Get questions (all quizzes combined)
        questions = db.query(Question).filter(
            Question.topic_id == topic.id
        ).order_by(Question.quiz_set, Question.display_order).all()

        print(f"  Questions: {len(questions)}")

        # Generate HTML
        theory_html = generate_theory_html(sections)
        quiz_html = ''  # Will be generated dynamically by JavaScript
        quiz_selector_html = generate_quiz_selector_html(questions)
        all_quiz_data_json = generate_all_quiz_data_json(questions)

        # Determine if multiple quiz sets exist
        quiz_sets = set(q.quiz_set if q.quiz_set else 1 for q in questions)
        has_multiple_quizzes = len(quiz_sets) > 1

        # Set display properties based on quiz count
        if has_multiple_quizzes:
            placeholder_display = 'display: block;'
            form_display = 'display: none;'
        else:
            placeholder_display = 'display: none;'
            form_display = 'display: block;'

        # Fill template
        template = get_topic_html_template()
        html = template.format(
            title=topic.title,
            description=topic.description,
            theory_html=theory_html,
            quiz_html=quiz_html,
            quiz_selector_html=quiz_selector_html,
            all_quiz_data_json=all_quiz_data_json,
            placeholder_display=placeholder_display,
            form_display=form_display
        )

        # Write file
        output_file = topics_dir / f'{topic.id}.html'
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(html)

        print(f"  ✓ Generated {output_file}")

    # Generate topics data for index.html
    topics_data = []
    for topic in topics:
        topics_data.append({
            'id': topic.id,
            'title': topic.title,
            'description': topic.description,
            'difficulty': topic.difficulty,
            'total_questions': topic.total_questions
        })

    # Update index.html with topics data
    index_file = output_dir / 'index.html'
    with open(index_file, 'r', encoding='utf-8') as f:
        index_html = f.read()

    # Replace topics array (either placeholder or existing data)
    topics_json = json.dumps(topics_data, ensure_ascii=False)

    # Try to replace placeholder first
    if 'TOPICS_DATA' in index_html:
        index_html = index_html.replace('TOPICS_DATA', topics_json)
    else:
        # Replace existing topics array using regex
        import re
        pattern = r'const topics = \[.*?\];'
        replacement = f'const topics = {topics_json};'
        index_html = re.sub(pattern, replacement, index_html, flags=re.DOTALL)

    with open(index_file, 'w', encoding='utf-8') as f:
        f.write(index_html)

    print(f"\n✓ Updated index.html with topics data")
    print(f"\n{'='*60}")
    print(f"✅ Static site generated successfully!")
    print(f"{'='*60}")
    print(f"\nLocation: {output_dir}")
    print(f"\nTo view:")
    print(f"  1. cd {output_dir}")
    print(f"  2. python3 -m http.server 8080")
    print(f"  3. Open http://localhost:8080")


def main():
    """Main function"""
    print("=" * 60)
    print("Generating Static HTML Site")
    print("=" * 60)

    db = SessionLocal()

    try:
        generate_static_site(db)
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
