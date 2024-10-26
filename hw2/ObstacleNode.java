public class ObstacleNode {
  public Obstacle data;
  public ObstacleNode next; 
  
  public Obstacle getData() {
    return data;
  }
  
  public ObstacleNode getNext() {
    return next;
  }
  
  public void setData(Obstacle data) {
     this.data = data;
  }
  
  public void setNext(ObstacleNode next) {
    this.next = next;
  }
  
  public ObstacleNode(Obstacle data, ObstacleNode node) {
    setData(data);
    setNext(node);
  }
}
