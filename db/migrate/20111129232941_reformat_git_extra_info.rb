class ReformatGitExtraInfo < ActiveRecord::Migration
  def self.up
    Repository.find(:all, :conditions => ['type = ?', 'Git']).each do |repo|
      if repo.extra_info.key?('branches')
        repo.extra_info['head_scmids'] =
          repo.extra_info['branches'].map{|br, h| h['last_scmid']}
        repo.extra_info.delete('branches')
        repo.write_attribute(:extra_info, repo.extra_info)
        repo.save
      end
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
