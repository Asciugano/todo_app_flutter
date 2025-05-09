enum PriorityLevel {
  low(0, 'bassa'),
  medium(1, 'media'), 
  high(2, 'alta');
  
  final int level;
  final String label;
  
  const PriorityLevel(this.level, this.label);
}