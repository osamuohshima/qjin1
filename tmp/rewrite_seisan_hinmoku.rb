$KCODE = "UTF8"

def rewrite_seisan_hinmoku  # temporally method
    File.open("seisan_hinmoku.txt","r") do |f|
		  (1..5).each do |i| 
				line= f.gets
        p a= line.split()
				p a[0].to_i, a[1].to_s

      end
		end
end

rewrite_seisan_hinmoku
