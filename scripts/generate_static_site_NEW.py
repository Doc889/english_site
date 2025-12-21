#!/usr/bin/env python3
"""
Generate static HTML site from lesson text files
NO DATABASE NEEDED - reads directly from .txt files
"""

import json
import re
from pathlib import Path
from collections import defaultdict


def parse_lesson_file(file_path):
    """Parse a lesson .txt file into theory and quiz data"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split into title, theory, and quizzes
    lines = content.split('\n')
    title = lines[0].strip()

    # Find where quizzes start
    quiz_start = content.find('КВИЗ 1')

    if quiz_start == -1:
        # No quizzes found
        theory_content = content
        quiz_content = ''
    else:
        theory_content = content[:quiz_start].strip()
        quiz_content = content[quiz_start:].strip()

    return {
        'title': title,
        'theory': theory_content,
        'quizzes': quiz_content
    }


def parse_theory_sections(theory_content):
    """Extract theory sections from content - simplified parser"""
    sections = []
    lines = theory_content.split('\n')

    # Skip title and intro, start looking for sections
    i = 2
    current_section = None
    current_content = []
    current_examples = []
    prev_line_empty = False

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        # Track blank lines
        if not stripped:
            prev_line_empty = True
            i += 1
            continue

        # Check if this is a MAIN section title (not subsection):
        # Main sections are like "Can / Can't", "Главное про модальные глаголы"
        # Subsections like "Утверждения:" or "Вопросы:" should be treated as content headers
        is_section_title = (
            prev_line_empty and
            10 < len(stripped) < 60 and  # Not too short, not too long
            not stripped.startswith(('•', '✔', '❌', '💡', '-', 'I ', 'You ', 'He ', 'She ', 'We ', 'They ', 'It ', '1️⃣', '2️⃣', '3️⃣')) and
            not stripped[0].islower() and
            '—' not in stripped and  # Not an example sentence
            not stripped.endswith('.') and
            not stripped.endswith(':') and  # Subsections end with :
            not stripped.endswith(')') and
            '?' not in stripped and
            (' / ' in stripped or 'про' in stripped.lower() or 'между' in stripped.lower() or 'ошибки' in stripped.lower())
        )

        if is_section_title and len(sections) < 10:
            # Save previous section
            if current_section:
                sections.append({
                    'title': current_section,
                    'content': '\n'.join(current_content),
                    'examples': current_examples
                })

            # Start new section
            current_section = stripped
            current_content = []
            current_examples = []
        else:
            # It's content or an example
            if any(stripped.startswith(marker) for marker in ['•', '✔', '❌', '💡', '-', '→', '1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣']):
                current_examples.append(stripped)
            elif '—' in stripped or len(stripped) < 100:
                # Likely an example (has translation or is short)
                current_examples.append(stripped)
            else:
                # Longer paragraph text
                current_content.append(stripped)

        prev_line_empty = False
        i += 1

    # Save last section
    if current_section:
        sections.append({
            'title': current_section,
            'content': '\n'.join(current_content),
            'examples': current_examples
        })

    return sections


def parse_quizzes(quiz_content):
    """Parse quiz questions from content"""
    if not quiz_content:
        return {}

    questions_by_quiz = defaultdict(list)

    # Split by КВИЗ
    quiz_pattern = r'КВИЗ (\d+)[^\n]*\n'
    parts = re.split(quiz_pattern, quiz_content)

    for i in range(1, len(parts), 2):
        quiz_num = int(parts[i])
        quiz_text = parts[i + 1]

        # Parse questions
        question_blocks = quiz_text.strip().split('\n\n')

        for block in question_blocks:
            if not block.strip():
                continue

            lines = block.strip().split('\n')
            if len(lines) < 2:
                continue

            question_text = lines[0]
            options_line = lines[1] if len(lines) > 1 else ''

            # Parse options: A) option1 B) option2 C) option3 D) option4 ✅ C
            match = re.search(r'A\)\s*([^B]+)B\)\s*([^C]+)C\)\s*([^D]+)D\)\s*([^✅]+)✅\s*([A-D])', options_line)

            if match:
                options = [
                    match.group(1).strip(),
                    match.group(2).strip(),
                    match.group(3).strip(),
                    match.group(4).strip()
                ]
                correct_letter = match.group(5).strip()
                correct_index = ord(correct_letter) - ord('A')

                questions_by_quiz[quiz_num].append({
                    'text': question_text,
                    'options': options,
                    'correct_index': correct_index
                })

    return dict(questions_by_quiz)


def get_topic_metadata():
    """Define metadata for all topics"""
    return [
        {
            'id': 'alphabet-pronunciation',
            'file': 'foundation.txt',
            'title': 'Закладываем фундамент',
            'description': 'Базовые принципы английского языка: структура, глаголы и конструкции'
        },
        {
            'id': 'greetings-introductions',
            'file': 'nouns.txt',
            'title': 'Существительные',
            'description': 'Исчисляемые и неисчисляемые существительные, множественное число'
        },
        {
            'id': 'articles',
            'file': 'articles.txt',
            'title': 'Артикли',
            'description': 'Артикли a, an, the и нулевой артикль'
        },
        {
            'id': 'pronouns',
            'file': 'pronouns.txt',
            'title': 'Местоимения',
            'description': 'Личные, объектные, притяжательные и указательные местоимения'
        },
        {
            'id': 'adjectives',
            'file': 'adjectives.txt',
            'title': 'Прилагательные',
            'description': 'Позиция прилагательных, степени сравнения и формы'
        },
        {
            'id': 'to_be',
            'file': 'to_be.txt',
            'title': 'Глагол to be',
            'description': 'Глагол to be (am/is/are) - самый базовый глагол английского языка'
        },
        {
            'id': 'present_simple',
            'file': 'present_simple.txt',
            'title': 'Present Simple',
            'description': 'Настоящее простое время - факты, привычки и рутина'
        },
        {
            'id': 'modal_verbs',
            'file': 'modal_verbs.txt',
            'title': 'Модальные глаголы',
            'description': 'Can, must, should - модальные глаголы для выражения способности, необходимости и совета'
        },
        {
            'id': 'there_is_are',
            'file': 'there_is_are.txt',
            'title': 'There is / There are',
            'description': 'Конструкция для описания наличия предметов и людей'
        },
        {
            'id': 'prepositions_place',
            'file': 'prepositions_place.txt',
            'title': 'Предлоги места',
            'description': 'Предлоги in, on, under, next to, between для описания местоположения'
        },
        {
            'id': 'question_words',
            'file': 'question_words.txt',
            'title': 'Вопросительные слова',
            'description': 'What, where, who, when, why, how - основные вопросительные слова'
        },
        {
            'id': 'numbers_dates_time',
            'file': 'numbers_dates_time.txt',
            'title': 'Числа, даты и время',
            'description': 'Как называть числа, даты и время по-английски'
        },
        {
            'id': 'present_continuous',
            'file': 'present_continuous.txt',
            'title': 'Present Continuous',
            'description': 'Настоящее продолженное время для действий, происходящих сейчас'
        },
    ]


def generate_theory_html(sections):
    """Generate HTML for theory sections"""
    html = ''

    for section in sections:
        html += f'''
        <div class="rule-section">
            <h3 class="rule-title">{section['title']}</h3>
            <p class="rule-content">{section['content']}</p>
'''

        if section['examples']:
            html += '            <div class="examples">\n'
            for example in section['examples']:
                html += f'                <div class="example">{example}</div>\n'
            html += '            </div>\n'

        html += '        </div>\n'

    return html


def generate_quiz_selector_html(quizzes_data):
    """Generate HTML for quiz selector buttons"""
    if len(quizzes_data) <= 1:
        return ''

    buttons = []
    for quiz_num in sorted(quizzes_data.keys()):
        buttons.append(
            f'<button type="button" class="quiz-selector-btn" data-quiz="{quiz_num}" '
            f'onclick="loadQuiz({quiz_num})">Тест {quiz_num}</button>'
        )

    return '\n                '.join(buttons)


def generate_quiz_data_json(quizzes_data):
    """Generate JSON data for all quizzes"""
    quiz_json = {}

    for quiz_num, questions in quizzes_data.items():
        quiz_json[quiz_num] = []
        for q in questions:
            quiz_json[quiz_num].append({
                'text': q['text'],
                'options': q['options'],
                'correct_index': q['correct_index']
            })

    return json.dumps(quiz_json, ensure_ascii=False)


def get_topic_html_template():
    """HTML template for topic pages"""
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
        }}

        #quiz-selector {{
            margin-bottom: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.8rem;
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
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
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
            padding: 1rem 2rem;
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
    </style>
</head>
<body>
    <header>
        <div class="container">
            <a href="../index.html" class="back-link">← Назад ко всем темам</a>
            <h1>{title}</h1>
            <p class="description">{description}</p>
        </div>
    </header>

    <main>
        <h2 class="section-title">Теория</h2>

        {theory_html}

        <div class="quiz-section">
            <h2 class="section-title">Проверь себя</h2>

            <div id="quiz-selector">
                {quiz_selector_html}
            </div>

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
        const allQuizData = {all_quiz_data_json};
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

            form.scrollIntoView({{ behavior: 'smooth', block: 'start' }});
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


def generate_index_html(topics_data):
    """Generate index.html"""
    return '''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Английский язык - Бесплатное обучение</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--color-bg);
            color: var(--color-text);
            line-height: 1.7;
            overflow-x: hidden;
        }

        header {
            top: 0;
            z-index: 100;
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
            color: var(--color-white);
            padding: 4rem 2rem;
            text-align: center;
        }

        .main-title {
            font-family: var(--font-display);
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }

        .subtitle {
            font-size: 1.3rem;
            opacity: 0.95;
            font-weight: 500;
        }

        main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }

        .level-section {
            margin-bottom: 4rem;
        }

        .level-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid var(--color-primary);
        }

        .level-badge {
            padding: 0.5rem 1.5rem;
            background: var(--color-primary);
            color: var(--color-white);
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .level-title {
            font-family: var(--font-display);
            font-size: 2.5rem;
            color: var(--color-text);
            font-weight: 700;
        }

        .topics-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .topic-item {
            background: var(--color-white);
            border: 2px solid var(--color-accent);
            padding: 1.5rem;
            border-radius: 16px;
            transition: var(--transition);
            cursor: pointer;
            text-decoration: none;
            color: var(--color-text);
            display: block;
        }

        .topic-item:hover {
            border-color: var(--color-primary);
            background: var(--color-bg-alt);
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
        }

        .topic-item h3 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--color-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .topic-item h3::before {
            content: '•';
            font-size: 1.5rem;
        }

        .topic-item p {
            font-size: 0.9rem;
            color: var(--color-text-light);
            line-height: 1.5;
        }

        footer {
            background: var(--color-primary);
            color: var(--color-white);
            padding: 3rem 2rem;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-content p {
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .main-title {
                font-size: 2.5rem;
            }

            .subtitle {
                font-size: 1.1rem;
            }

            .level-title {
                font-size: 2rem;
            }

            .topics-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1 class="main-title">Английский язык</h1>
        <p class="subtitle">Бесплатное обучение • Все уровни • 100% практика</p>
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
        const topics = ''' + json.dumps(topics_data, ensure_ascii=False) + ''';

        const container = document.getElementById('topics-container');

        topics.forEach(topic => {
            const card = document.createElement('a');
            card.href = `topics/${topic.id}.html`;
            card.className = 'topic-item';

            card.innerHTML = `
                <h3>${topic.title}</h3>
                <p>${topic.description}</p>
            `;

            container.appendChild(card);
        });
    </script>
</body>
</html>'''


def main():
    """Main generation function"""
    print("=" * 60)
    print("Generating Static HTML Site from Text Files")
    print("=" * 60)

    lessons_dir = Path(__file__).parent.parent / 'english_lessons'
    output_dir = Path(__file__).parent.parent / 'static_site'
    topics_dir = output_dir / 'topics'

    # Create output directories
    output_dir.mkdir(exist_ok=True)
    topics_dir.mkdir(exist_ok=True)

    # Get topic metadata
    topics_metadata = get_topic_metadata()
    topics_for_index = []

    print(f"\nFound {len(topics_metadata)} topics to generate\n")

    # Generate each topic page
    for topic_meta in topics_metadata:
        print(f"Generating {topic_meta['id']}.html...")

        file_path = lessons_dir / topic_meta['file']

        if not file_path.exists():
            print(f"  ⚠️  File not found: {file_path}")
            continue

        # Parse lesson file
        lesson_data = parse_lesson_file(file_path)
        sections = parse_theory_sections(lesson_data['theory'])
        quizzes = parse_quizzes(lesson_data['quizzes'])

        total_questions = sum(len(q) for q in quizzes.values())

        print(f"  Theory sections: {len(sections)}")
        print(f"  Questions: {total_questions}")

        # Generate HTML components
        theory_html = generate_theory_html(sections)
        quiz_selector_html = generate_quiz_selector_html(quizzes)
        all_quiz_data_json = generate_quiz_data_json(quizzes)

        # Determine display properties
        has_multiple_quizzes = len(quizzes) > 1
        if has_multiple_quizzes:
            placeholder_display = 'display: block;'
            form_display = 'display: none;'
        else:
            placeholder_display = 'display: none;'
            form_display = 'display: block;'

        # Generate topic page
        template = get_topic_html_template()
        html = template.format(
            title=topic_meta['title'],
            description=topic_meta['description'],
            theory_html=theory_html,
            quiz_selector_html=quiz_selector_html,
            all_quiz_data_json=all_quiz_data_json,
            placeholder_display=placeholder_display,
            form_display=form_display
        )

        # Write file
        output_file = topics_dir / f"{topic_meta['id']}.html"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(html)

        print(f"  ✓ Generated {output_file}")

        # Add to index data
        topics_for_index.append({
            'id': topic_meta['id'],
            'title': topic_meta['title'],
            'description': topic_meta['description'],
            'total_questions': total_questions
        })

    # Generate index.html
    print("\nGenerating index.html...")
    index_html = generate_index_html(topics_for_index)
    with open(output_dir / 'index.html', 'w', encoding='utf-8') as f:
        f.write(index_html)

    print("✓ Generated index.html")

    print(f"\n{'='*60}")
    print(f"✅ Static site generated successfully!")
    print(f"{'='*60}")
    print(f"\nLocation: {output_dir}")
    print(f"\nTo view:")
    print(f"  1. cd {output_dir}")
    print(f"  2. python3 -m http.server 8080")
    print(f"  3. Open http://localhost:8080")


if __name__ == "__main__":
    main()
