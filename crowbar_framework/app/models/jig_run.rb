# Copyright 2012, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


####
# A run represents the execution of a Jig tool on a node, to apply a role (or potentially a set of them)

class JigRun < ActiveRecord::Base
  attr_accessible :name, :description, :type, :order, :result, :status, :jig_event_id

  validates_uniqueness_of :name, :case_sensitive => false, :message => I18n.t("db.notunique", :default=>"Name item must be unique")
  validates_format_of :name, :with=> /^[a-zA-Z][_a-zA-Z0-9]*$/, :message => I18n.t("db.lettersnumbers", :default=>"Name limited to [_a-zA-Z0-9]")
  
  belongs_to :jig_event  # the event triggering this run
  belongs_to :node_role   # The node this run (will) execute on.
  

  # The status values
  RUN_PENDING = 1
  RUN_EXECUTING = 2
  RUN_SUCCESS = 3
  RUN_FAIL = 4

  # grand-parent object (perhaps can be a belongs_to :through?)
  def jig
    self.jig_event.jig
  end

  def init
    puts "INIT JigRun"
  end

  # map attributes from jig node into array of JigAttributes
  def attrs_to_jig()
    puts "JWM placeholder"
  end

  def attrs_from_jig()
    #a = JigAttribute.new(:name => jig_attr, :value => node_attr_value)
    #a.save!
    puts "JWM placeholder"
  end
  
  def run_jig_on_node()
    puts "JWM placeholder"
  end
    
  # make sure I can get the map I need to put attrs in the DB
  def map(map_id)
    begin
      JigMap.find(map_id)
    rescue Exception => e
      Rails.logger.warn("Could not find JigMap.id #{map_id}: #{e.inspect}")
      return nil
    end
  end

  def as_json options={}
    {
     :name=> name,
     :id=> id,
     :description=> description,
     :order=> order,
     :result=> result,
     :status=> status,
     :jig_event_id=> jig_event_id,
     :type=> type,
     :created_at=> created_at,
     :updated_at=> updated_at
   }
  end

end
