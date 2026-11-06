-- Level 1: Easy - "Primeros Pasos"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'Primeros Pasos',
    '{
        "grid_width": 40,
        "grid_height": 16,
        "cell_size": 32,
        "spawn_j1": {"x": 1, "y": 14},
        "spawn_j2": {"x": 38, "y": 14},
        "goal": {"x": 19, "y": 3},
        "platforms": [
            {"x": 0, "y": 15, "width": 17, "height": 1, "type": "ground"},
            {"x": 4, "y": 13, "width": 3, "height": 1, "type": "platform"},
            {"x": 9, "y": 11, "width": 3, "height": 1, "type": "platform"},
            {"x": 4, "y": 9, "width": 3, "height": 1, "type": "platform"},
            {"x": 9, "y": 7, "width": 3, "height": 1, "type": "platform"},
            {"x": 14, "y": 5, "width": 4, "height": 1, "type": "platform"},
            {"x": 23, "y": 15, "width": 17, "height": 1, "type": "ground"},
            {"x": 33, "y": 13, "width": 3, "height": 1, "type": "platform"},
            {"x": 28, "y": 11, "width": 3, "height": 1, "type": "platform"},
            {"x": 33, "y": 9, "width": 3, "height": 1, "type": "platform"},
            {"x": 28, "y": 7, "width": 3, "height": 1, "type": "platform"},
            {"x": 22, "y": 5, "width": 4, "height": 1, "type": "platform"},
            {"x": 17, "y": 15, "width": 6, "height": 1, "type": "ground"},
            {"x": 18, "y": 4, "width": 4, "height": 1, "type": "goal_platform"}
        ],
        "hazards": [
            {"x": 12, "y": 14, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 26, "y": 14, "width": 2, "height": 1, "type": "spikes", "damage": 1}
        ],
        "collectibles": [
            {"x": 5, "y": 12, "type": "coin"},
            {"x": 10, "y": 10, "type": "coin"},
            {"x": 5, "y": 8, "type": "coin"},
            {"x": 10, "y": 6, "type": "coin"},
            {"x": 15, "y": 4, "type": "coin"},
            {"x": 34, "y": 12, "type": "coin"},
            {"x": 29, "y": 10, "type": "coin"},
            {"x": 34, "y": 8, "type": "coin"},
            {"x": 29, "y": 6, "type": "coin"},
            {"x": 24, "y": 4, "type": "coin"}
        ]
    }'::jsonb,
    'easy',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 2: Medium - "El Ascenso"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'El Ascenso',
    '{
        "grid_width": 44,
        "grid_height": 16,
        "cell_size": 32,
        "spawn_j1": {"x": 1, "y": 14},
        "spawn_j2": {"x": 42, "y": 14},
        "goal": {"x": 21, "y": 3},
        "platforms": [
            {"x": 0, "y": 15, "width": 15, "height": 1, "type": "ground"},
            {"x": 3, "y": 13, "width": 2, "height": 1, "type": "platform"},
            {"x": 7, "y": 11, "width": 2, "height": 1, "type": "platform"},
            {"x": 11, "y": 9, "width": 3, "height": 1, "type": "platform"},
            {"x": 15, "y": 7, "width": 2, "height": 1, "type": "platform"},
            {"x": 18, "y": 5, "width": 2, "height": 1, "type": "platform"},
            {"x": 29, "y": 15, "width": 15, "height": 1, "type": "ground"},
            {"x": 39, "y": 13, "width": 2, "height": 1, "type": "platform"},
            {"x": 35, "y": 11, "width": 2, "height": 1, "type": "platform"},
            {"x": 30, "y": 9, "width": 3, "height": 1, "type": "platform"},
            {"x": 27, "y": 7, "width": 2, "height": 1, "type": "platform"},
            {"x": 24, "y": 5, "width": 2, "height": 1, "type": "platform"},
            {"x": 15, "y": 15, "width": 14, "height": 1, "type": "ground"},
            {"x": 20, "y": 4, "width": 4, "height": 1, "type": "goal_platform"}
        ],
        "hazards": [
            {"x": 8, "y": 14, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 12, "y": 8, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 34, "y": 14, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 31, "y": 8, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 21, "y": 14, "width": 2, "height": 1, "type": "spikes", "damage": 1}
        ],
        "collectibles": [
            {"x": 4, "y": 12, "type": "coin"},
            {"x": 8, "y": 10, "type": "coin"},
            {"x": 12, "y": 7, "type": "coin"},
            {"x": 16, "y": 6, "type": "coin"},
            {"x": 19, "y": 4, "type": "coin"},
            {"x": 11, "y": 14, "type": "coin"},
            {"x": 39, "y": 12, "type": "coin"},
            {"x": 35, "y": 10, "type": "coin"},
            {"x": 31, "y": 7, "type": "coin"},
            {"x": 27, "y": 6, "type": "coin"},
            {"x": 24, "y": 4, "type": "coin"},
            {"x": 32, "y": 14, "type": "coin"}
        ]
    }'::jsonb,
    'medium',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 3: Hard - "Precisión Letal"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'Precisión Letal',
    '{
        "grid_width": 52,
        "grid_height": 22,
        "cell_size": 32,
        "spawn_j1": {"x": 1, "y": 20},
        "spawn_j2": {"x": 50, "y": 20},
        "goal": {"x": 25, "y": 4},
        "platforms": [
            {"x": 0, "y": 21, "width": 6, "height": 1, "type": "ground"},
            {"x": 9, "y": 21, "width": 5, "height": 1, "type": "ground"},
            {"x": 17, "y": 21, "width": 9, "height": 1, "type": "ground"},
            {"x": 12, "y": 18, "width": 2, "height": 1, "type": "platform"},
            {"x": 7, "y": 16, "width": 2, "height": 1, "type": "platform"},
            {"x": 12, "y": 14, "width": 3, "height": 1, "type": "platform"},
            {"x": 7, "y": 12, "width": 2, "height": 1, "type": "platform"},
            {"x": 2, "y": 10, "width": 2, "height": 1, "type": "platform"},
            {"x": 7, "y": 9, "width": 2, "height": 1, "type": "platform"},
            {"x": 13, "y": 8, "width": 2, "height": 1, "type": "platform"},
            {"x": 19, "y": 7, "width": 2, "height": 1, "type": "platform"},
            {"x": 46, "y": 21, "width": 6, "height": 1, "type": "ground"},
            {"x": 38, "y": 21, "width": 5, "height": 1, "type": "ground"},
            {"x": 26, "y": 21, "width": 9, "height": 1, "type": "ground"},
            {"x": 38, "y": 18, "width": 2, "height": 1, "type": "platform"},
            {"x": 43, "y": 16, "width": 2, "height": 1, "type": "platform"},
            {"x": 37, "y": 14, "width": 3, "height": 1, "type": "platform"},
            {"x": 43, "y": 12, "width": 2, "height": 1, "type": "platform"},
            {"x": 48, "y": 10, "width": 2, "height": 1, "type": "platform"},
            {"x": 43, "y": 9, "width": 2, "height": 1, "type": "platform"},
            {"x": 37, "y": 8, "width": 2, "height": 1, "type": "platform"},
            {"x": 31, "y": 7, "width": 2, "height": 1, "type": "platform"},
            {"x": 24, "y": 5, "width": 4, "height": 1, "type": "goal_platform"}
        ],
        "hazards": [
            {"x": 6, "y": 21, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 14, "y": 21, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 21, "y": 20, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 13, "y": 13, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 43, "y": 21, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 35, "y": 21, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 29, "y": 20, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 38, "y": 13, "width": 1, "height": 1, "type": "spikes", "damage": 1}
        ],
        "collectibles": [
            {"x": 13, "y": 17, "type": "coin"},
            {"x": 8, "y": 15, "type": "coin"},
            {"x": 13, "y": 12, "type": "coin"},
            {"x": 8, "y": 11, "type": "coin"},
            {"x": 3, "y": 9, "type": "coin"},
            {"x": 8, "y": 8, "type": "coin"},
            {"x": 14, "y": 7, "type": "coin"},
            {"x": 20, "y": 6, "type": "coin"},
            {"x": 38, "y": 17, "type": "coin"},
            {"x": 43, "y": 15, "type": "coin"},
            {"x": 38, "y": 12, "type": "coin"},
            {"x": 43, "y": 11, "type": "coin"},
            {"x": 48, "y": 9, "type": "coin"},
            {"x": 43, "y": 8, "type": "coin"},
            {"x": 37, "y": 7, "type": "coin"},
            {"x": 31, "y": 6, "type": "coin"}
        ]
    }'::jsonb,
    'hard',
    NULL
) ON CONFLICT DO NOTHING;

-- Level 4: Expert - "El Desafío Supremo"
INSERT INTO levels (title, grid_json, difficulty, created_by) VALUES (
    'El Desafío Supremo',
    '{
        "grid_width": 60,
        "grid_height": 24,
        "cell_size": 32,
        "spawn_j1": {"x": 1, "y": 22},
        "spawn_j2": {"x": 58, "y": 22},
        "goal": {"x": 29, "y": 5},
        "platforms": [
            {"x": 0, "y": 23, "width": 7, "height": 1, "type": "ground"},
            {"x": 10, "y": 23, "width": 5, "height": 1, "type": "ground"},
            {"x": 18, "y": 23, "width": 12, "height": 1, "type": "ground"},
            {"x": 19, "y": 20, "width": 3, "height": 1, "type": "platform"},
            {"x": 24, "y": 18, "width": 3, "height": 1, "type": "platform"},
            {"x": 19, "y": 16, "width": 3, "height": 1, "type": "platform"},
            {"x": 24, "y": 14, "width": 3, "height": 1, "type": "platform"},
            {"x": 19, "y": 12, "width": 3, "height": 1, "type": "platform"},
            {"x": 24, "y": 10, "width": 3, "height": 1, "type": "platform"},
            {"x": 25, "y": 8, "width": 2, "height": 1, "type": "platform"},
            {"x": 53, "y": 23, "width": 7, "height": 1, "type": "ground"},
            {"x": 45, "y": 23, "width": 5, "height": 1, "type": "ground"},
            {"x": 30, "y": 23, "width": 12, "height": 1, "type": "ground"},
            {"x": 38, "y": 20, "width": 3, "height": 1, "type": "platform"},
            {"x": 33, "y": 18, "width": 3, "height": 1, "type": "platform"},
            {"x": 38, "y": 16, "width": 3, "height": 1, "type": "platform"},
            {"x": 33, "y": 14, "width": 3, "height": 1, "type": "platform"},
            {"x": 38, "y": 12, "width": 3, "height": 1, "type": "platform"},
            {"x": 33, "y": 10, "width": 3, "height": 1, "type": "platform"},
            {"x": 33, "y": 8, "width": 2, "height": 1, "type": "platform"},
            {"x": 28, "y": 6, "width": 4, "height": 1, "type": "goal_platform"}
        ],
        "hazards": [
            {"x": 7, "y": 23, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 15, "y": 23, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 12, "y": 22, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 24, "y": 22, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 25, "y": 17, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 25, "y": 13, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 20, "y": 11, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 50, "y": 23, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 42, "y": 23, "width": 3, "height": 1, "type": "spikes", "damage": 1},
            {"x": 47, "y": 22, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 34, "y": 22, "width": 2, "height": 1, "type": "spikes", "damage": 1},
            {"x": 34, "y": 17, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 34, "y": 13, "width": 1, "height": 1, "type": "spikes", "damage": 1},
            {"x": 39, "y": 11, "width": 1, "height": 1, "type": "spikes", "damage": 1}
        ],
        "collectibles": [
            {"x": 20, "y": 19, "type": "coin"},
            {"x": 25, "y": 17, "type": "coin"},
            {"x": 20, "y": 15, "type": "coin"},
            {"x": 25, "y": 13, "type": "coin"},
            {"x": 20, "y": 11, "type": "coin"},
            {"x": 25, "y": 9, "type": "coin"},
            {"x": 26, "y": 7, "type": "coin"},
            {"x": 13, "y": 21, "type": "coin"},
            {"x": 39, "y": 19, "type": "coin"},
            {"x": 34, "y": 17, "type": "coin"},
            {"x": 39, "y": 15, "type": "coin"},
            {"x": 34, "y": 13, "type": "coin"},
            {"x": 39, "y": 11, "type": "coin"},
            {"x": 34, "y": 9, "type": "coin"},
            {"x": 33, "y": 7, "type": "coin"},
            {"x": 46, "y": 21, "type": "coin"}
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