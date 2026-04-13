-- Demo topic seed — "Telugu Letters I" (matches kDemoTopics in Flutter)
INSERT INTO public.topics (
  id,
  title_en, title_te, title_hi,
  subject_domain, mentor_id,
  base_difficulty,
  jingle_config,
  boss_fight_config,
  is_published,
  sort_order
) VALUES (
  'a0000000-0000-0000-0000-000000000001'::UUID,
  'Telugu Letters I',
  'తెలుగు అక్షరాలు I',
  'तेलुगू अक्षर I',
  'language',
  'arya',
  1,
  '{
    "audio_url": "topics/telugu-letters-1/jingle.mp3",
    "duration_ms": 30000,
    "title": "The Akshara Song",
    "lyrics": [
      {"start_ms": 0, "end_ms": 3000, "text_en": "అ is for Aapple, bright and red"},
      {"start_ms": 3000, "end_ms": 6000, "text_en": "ఆ is for Aakaasham up ahead"},
      {"start_ms": 6000, "end_ms": 9000, "text_en": "ఇ is for Illu, our sweet home"},
      {"start_ms": 9000, "end_ms": 12000, "text_en": "ఈ is for Eega, they freely roam"}
    ]
  }'::JSONB,
  '{
    "questions": [
      {
        "id": "q-drag-1",
        "type": "drag_drop",
        "prompt_en": "Match the letter to its picture",
        "difficulty": 1,
        "pairs": [
          {"id": "అ", "label": "అ", "image": "apple"},
          {"id": "ఆ", "label": "ఆ", "image": "sky"},
          {"id": "ఇ", "label": "ఇ", "image": "house"}
        ]
      },
      {
        "id": "q-tap-1",
        "type": "speed_tap",
        "prompt_en": "Which letter sounds like Aa?",
        "difficulty": 1,
        "options": ["అ", "ఆ", "ఇ", "ఈ"],
        "correct": "ఆ"
      }
    ]
  }'::JSONB,
  true,
  1
)
ON CONFLICT (id) DO NOTHING;

-- Telugu Letters II (locked until I complete)
INSERT INTO public.topics (
  id, title_en, title_te, title_hi,
  subject_domain, mentor_id, base_difficulty,
  jingle_config, boss_fight_config,
  is_published, sort_order, prerequisite_ids
) VALUES (
  'a0000000-0000-0000-0000-000000000002'::UUID,
  'Telugu Letters II', 'తెలుగు అక్షరాలు II', 'तेलुगू अक्षर II',
  'language', 'arya', 2,
  '{}'::JSONB, '{}'::JSONB,
  true, 2,
  ARRAY['a0000000-0000-0000-0000-000000000001'::UUID]
)
ON CONFLICT (id) DO NOTHING;
