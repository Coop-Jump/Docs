-- Level 1: Easy - "Primeros Pasos"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'Primeros Pasos',
    '{
        "grid_width": 20,
        "grid_height": 15,
        "cell_size": 32,
        "spawn_j1": { "x": 1, "y": 13 },
        "spawn_j2": { "x": 18, "y": 13 },
        "goal": { "x": 10, "y": 1 },
        "platforms": [
            { "x": 0, "y": 14, "width": 20, "height": 1, "type": "ground" },
            { "x": 3, "y": 11, "width": 4, "height": 1, "type": "platform" },
            { "x": 13, "y": 11, "width": 4, "height": 1, "type": "platform" },
            { "x": 7, "y": 8, "width": 6, "height": 1, "type": "platform" },
            { "x": 5, "y": 5, "width": 10, "height": 1, "type": "platform" },
            { "x": 9, "y": 2, "width": 2, "height": 1, "type": "goal_platform" }
        ],
        "hazards": [],
        "collectibles": []
    }'::jsonb,
    'easy',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 2: Medium - "El Ascenso"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'El Ascenso',
    '{
        "grid_width": 24,
        "grid_height": 18,
        "cell_size": 32,
        "spawn_j1": { "x": 1, "y": 16 },
        "spawn_j2": { "x": 22, "y": 16 },
        "goal": { "x": 12, "y": 1 },
        "platforms": [
            { "x": 0, "y": 17, "width": 24, "height": 1, "type": "ground" },
            { "x": 2, "y": 14, "width": 5, "height": 1, "type": "platform" },
            { "x": 17, "y": 14, "width": 5, "height": 1, "type": "platform" },
            { "x": 5, "y": 11, "width": 4, "height": 1, "type": "platform" },
            { "x": 15, "y": 11, "width": 4, "height": 1, "type": "platform" },
            { "x": 9, "y": 8, "width": 6, "height": 1, "type": "platform" },
            { "x": 4, "y": 5, "width": 4, "height": 1, "type": "platform" },
            { "x": 16, "y": 5, "width": 4, "height": 1, "type": "platform" },
            { "x": 8, "y": 2, "width": 8, "height": 1, "type": "platform" },
            { "x": 11, "y": 0, "width": 2, "height": 1, "type": "goal_platform" }
        ],
        "hazards": [
            { "x": 10, "y": 13, "width": 4, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 11, "y": 7, "width": 2, "height": 1, "type": "spikes", "damage": 1 }
        ],
        "collectibles": [
            { "x": 7, "y": 10, "type": "coin" },
            { "x": 16, "y": 10, "type": "coin" },
            { "x": 11, "y": 4, "type": "coin" }
        ]
    }'::jsonb,
    'medium',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 3: Hard - "Precisión Letal"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'Precisión Letal',
    '{
        "grid_width": 28,
        "grid_height": 20,
        "cell_size": 32,
        "spawn_j1": { "x": 1, "y": 18 },
        "spawn_j2": { "x": 26, "y": 18 },
        "goal": { "x": 14, "y": 1 },
        "platforms": [
            { "x": 0, "y": 19, "width": 28, "height": 1, "type": "ground" },
            { "x": 2, "y": 16, "width": 3, "height": 1, "type": "platform" },
            { "x": 23, "y": 16, "width": 3, "height": 1, "type": "platform" },
            { "x": 6, "y": 14, "width": 2, "height": 1, "type": "platform" },
            { "x": 20, "y": 14, "width": 2, "height": 1, "type": "platform" },
            { "x": 4, "y": 12, "width": 3, "height": 1, "type": "platform" },
            { "x": 21, "y": 12, "width": 3, "height": 1, "type": "platform" },
            { "x": 8, "y": 10, "width": 2, "height": 1, "type": "platform" },
            { "x": 18, "y": 10, "width": 2, "height": 1, "type": "platform" },
            { "x": 6, "y": 8, "width": 4, "height": 1, "type": "platform" },
            { "x": 18, "y": 8, "width": 4, "height": 1, "type": "platform" },
            { "x": 10, "y": 6, "width": 8, "height": 1, "type": "platform" },
            { "x": 12, "y": 3, "width": 4, "height": 1, "type": "platform" },
            { "x": 13, "y": 0, "width": 2, "height": 1, "type": "goal_platform" }
        ],
        "hazards": [
            { "x": 5, "y": 15, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 22, "y": 15, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 9, "y": 13, "width": 10, "height": 1, "type": "lava", "damage": 2 },
            { "x": 11, "y": 9, "width": 6, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 7, "y": 7, "width": 2, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 19, "y": 7, "width": 2, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 13, "y": 4, "width": 2, "height": 1, "type": "spikes", "damage": 1 }
        ],
        "collectibles": [
            { "x": 3, "y": 15, "type": "coin" },
            { "x": 24, "y": 15, "type": "coin" },
            { "x": 5, "y": 11, "type": "coin" },
            { "x": 22, "y": 11, "type": "coin" },
            { "x": 9, "y": 9, "type": "coin" },
            { "x": 18, "y": 9, "type": "coin" },
            { "x": 13, "y": 5, "type": "gem" }
        ]
    }'::jsonb,
    'hard',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 4: Expert - "El Desafío Supremo"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'El Desafío Supremo',
    '{
        "grid_width": 32,
        "grid_height": 22,
        "cell_size": 32,
        "spawn_j1": { "x": 1, "y": 20 },
        "spawn_j2": { "x": 30, "y": 20 },
        "goal": { "x": 16, "y": 1 },
        "platforms": [
            { "x": 0, "y": 21, "width": 32, "height": 1, "type": "ground" },
            { "x": 2, "y": 18, "width": 2, "height": 1, "type": "platform" },
            { "x": 28, "y": 18, "width": 2, "height": 1, "type": "platform" },
            { "x": 5, "y": 16, "width": 3, "height": 1, "type": "platform" },
            { "x": 24, "y": 16, "width": 3, "height": 1, "type": "platform" },
            { "x": 4, "y": 14, "width": 2, "height": 1, "type": "moving", "move_range": 3, "move_speed": 1 },
            { "x": 26, "y": 14, "width": 2, "height": 1, "type": "moving", "move_range": 3, "move_speed": 1 },
            { "x": 8, "y": 12, "width": 4, "height": 1, "type": "platform" },
            { "x": 20, "y": 12, "width": 4, "height": 1, "type": "platform" },
            { "x": 6, "y": 10, "width": 2, "height": 1, "type": "platform" },
            { "x": 24, "y": 10, "width": 2, "height": 1, "type": "platform" },
            { "x": 10, "y": 8, "width": 3, "height": 1, "type": "platform" },
            { "x": 19, "y": 8, "width": 3, "height": 1, "type": "platform" },
            { "x": 8, "y": 6, "width": 2, "height": 1, "type": "disappearing", "disappear_delay": 1000 },
            { "x": 22, "y": 6, "width": 2, "height": 1, "type": "disappearing", "disappear_delay": 1000 },
            { "x": 12, "y": 4, "width": 8, "height": 1, "type": "platform" },
            { "x": 15, "y": 2, "width": 2, "height": 1, "type": "platform" },
            { "x": 15, "y": 0, "width": 2, "height": 1, "type": "goal_platform" }
        ],
        "hazards": [
            { "x": 3, "y": 17, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 28, "y": 17, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 6, "y": 15, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 25, "y": 15, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 9, "y": 13, "width": 14, "height": 1, "type": "lava", "damage": 2 },
            { "x": 7, "y": 11, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 24, "y": 11, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 11, "y": 9, "width": 10, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 9, "y": 7, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 22, "y": 7, "width": 1, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 13, "y": 5, "width": 6, "height": 1, "type": "spikes", "damage": 1 },
            { "x": 14, "y": 3, "width": 4, "height": 1, "type": "lava", "damage": 2 }
        ],
        "collectibles": [
            { "x": 3, "y": 17, "type": "coin" },
            { "x": 28, "y": 17, "type": "coin" },
            { "x": 5, "y": 15, "type": "coin" },
            { "x": 26, "y": 15, "type": "coin" },
            { "x": 9, "y": 11, "type": "coin" },
            { "x": 22, "y": 11, "type": "coin" },
            { "x": 11, "y": 7, "type": "gem" },
            { "x": 20, "y": 7, "type": "gem" },
            { "x": 15, "y": 3, "type": "star" }
        ]
    }'::jsonb,
    'expert',
    NULL
) ON CONFLICT DO NOTHING;

-- Verify the inserted levels
SELECT id, title, difficulty,
       grid_json->>'grid_width' as width,
       grid_json->>'grid_height' as height,
       jsonb_array_length(grid_json->'platforms') as platform_count,
       jsonb_array_length(grid_json->'hazards') as hazard_count,
       jsonb_array_length(grid_json->'collectibles') as collectible_count
FROM levels
ORDER BY
    CASE difficulty
        WHEN 'easy' THEN 1
        WHEN 'medium' THEN 2
        WHEN 'hard' THEN 3
        WHEN 'expert' THEN 4
    END;