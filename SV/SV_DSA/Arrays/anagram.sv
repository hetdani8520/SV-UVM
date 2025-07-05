module anagram;
  string s1 = "silent";
  string s2 = "listea";
  
  bit [4:0] asso_s1[string] = '{default:0};
  bit [4:0] asso_s2[string] = '{default:0};
  
  string key;
  
  initial begin
    for(int i=0;i<s1.len();i++) begin
    asso_s1[s1[i]]++;
  end
  
  for(int i=0;i<s2.len();i++) begin
    asso_s2[s2[i]]++;
  end
  /*
  foreach(asso_s1[i]) begin
      $display("%s",i);
  end
  */
    if(asso_s1.first(key)) begin //for key in asso_s1
      do begin
        if(asso_s2.exists(key)) begin //if matching key exists in asso_s2
          if(asso_s1[key] == asso_s2[key]) begin
            $display("MATCH!string s1=%s,occurrence_s1=%d, string s2=%s,occurrence_s2=%d",key,asso_s1[key],key,asso_s2[key]);
          end
          else begin //if matching key exists but occurrence of it is diff in asso_s2
            $display("MISMATCH!string s1=%s,occurrence_s1=%d, string s2=%s,occurrence_s2=%d",key,asso_s1[key],key,asso_s2[key]);
            break;
          end
      end
        else begin //if matching key does not exist in asso_s2
          $display("no matching key found in asso_s2 for key=%s",key);
          break;
        end
      end
      while(asso_s1.next(key));
    end
  
    
    
  end
endmodule