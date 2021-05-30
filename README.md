# Invaders scanner

![Rspec](https://github.com/mariuszmikolajczak/invaders-scanner/workflows/Rspec/badge.svg)

Task description [click here](ASSIGNMENT.md).

## Usage

Example script `bin/example_usage.rb` contains example patterns from the task description.

Invader and Search area are the same objects.

```ruby
radar_example = '' # Loaded from file or something
string = <<-PATTERN
--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
PATTERN 
invader = InvadersScanner::Area.from_string(string) # Invader definition
search_area = InvadersScanner::Area.from_string(radar_example) # Radar example definition

# Scanning
# default minimum_similarity is 80 
scanner = InvadersScanner::Scanner.new(input: search_area, search_pattern: invader, minimum_similarity: 70)
matches = scanner.scan # Scan returns array of Match instances
matches.each do
  match.similarity # Similarity in %
  match.coordinates # Array of coordinates [start_coordinate, end_coordinate]
end
```

## Notes

- Current algorithm doesnt check partial patterns on edges, eg.
Search pattern:
```text
--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
```
Looking in area:
```text
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
-----------
-----------
-----------
```
- Searching algorithm is based on brute force, chunks of size pattern are taken from input
and compared, after comparing next chunk is taken if fits in area.
  
## Development

- Running tests `bundle exec rspec` generates SimpleCov report in `coverage` directory.
- Rubocop linter `bundle exec rubocop`
